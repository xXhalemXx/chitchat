import 'dart:async';
import 'dart:developer';

import 'package:chitchat/src/core/constants/strings.dart';
import 'package:chitchat/src/core/models/user_data.dart';
import 'package:chitchat/src/core/networking/models/call_history_model.dart';
import 'package:chitchat/src/core/networking/models/ice_candidate_model.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/core/routes/names.dart';
import 'package:chitchat/src/core/routes/router.dart';
import 'package:chitchat/src/features/home/data/repo/repo.dart';
import 'package:chitchat/src/features/home/presentation/pages/call_pages/outgoing_call_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit({required this.homeRepository}) : super(CallState.initial());
  HomeRepository homeRepository;

  RTCPeerConnection? _peerConnection;

  MediaStream? _localStream;
  String callId = '';

  StreamSubscription? incomingDataSubscription;
  StreamSubscription? outgoingDataSubscription;

  /// call status can be 5 values in firestore
  /// 0: call is initiated
  /// 1: call is answered
  /// 2: call is rejected
  /// 3: user in not answering
  /// 4: user in another call
  /// 5: call is ended

  // listen for incoming video call
  void listenForIncomingCall() async {
    // listen for incoming calls
    homeRepository.onNewCallCreated().listen((data) async {
      // if the receiverId is the current user id show this call to user
      log('incoming call: $data');
      if (data[FirebaseStrings.receiverId] == UserData.currentUser!.uId) {
        // if the current call offer is null mean the user is not in another call
        log('current call offer: ${state.currentCallOffer}');
        if (!state.isThereIncomingCall) {
          // show the incoming call page to the user
          emit(state.copyWith(isThereIncomingCall: true));
          // start a timer for 30 seconds
          bool callHandled = false;
          Timer timer = Timer(Duration(seconds: 30), () async {
            if (!callHandled) {
              // if the user did not decide within 30 seconds, decline the call
              await homeRepository.updateCallStatus(
                  data[FirebaseStrings.callId], 3);
              log('call timed out');
              exitCallingPage(waitToShowMessage: false, isOutgoingCall: false);
            }
          });
          log('timer started');
          while (!callHandled) {
            // wait for user response for 500 milliseconds
            await Future.delayed(Duration(milliseconds: 500));
            if (state.acceptIncomingCall != null) {
              callHandled = true;
              timer.cancel();
              // depend on user to accept or decline the call
              if (state.acceptIncomingCall!) {
                // we accept the call
                await homeRepository.updateCallStatus(
                    data[FirebaseStrings.callId], 1);
                log('call accepted');
                // todo setup the call
              } else {
                // if user decline the call
                await homeRepository.updateCallStatus(
                    data[FirebaseStrings.callId], 2);
                log('call rejected');
                exitCallingPage(
                    waitToShowMessage: false, isOutgoingCall: false);
              }
            }
          }
        } else {
          log('user is in another call');
          // we decline the call if the user is in another call
          await homeRepository.updateCallStatus(
              data[FirebaseStrings.callId], 4);
        }
      }
    });
  }

  Future<void> exitOutgoingCall({required String receiverId}) async {
    await homeRepository.onCallEnd(
      callId,
      UserData.currentUser!.uId,
      CallHistoryModel(
          idOfOtherUser: receiverId, callTime: DateTime.now(), callStatus: 5),
    );
    exitCallingPage(waitToShowMessage: false, isOutgoingCall: true);
  }

  void initiateCall(
      {required UserModel receiver,
      required bool isAudioOn,
      required bool isVideoOn,
      required bool isFrontCameraSelected}) async {
    //we create a call document in firestore and use document id as call id
    String callId = await homeRepository.createCall(
        UserData.currentUser!.uId, receiver.uId, receiver.name);

    this.callId = callId;
    // _initRenderer();
    _setupPeerConnection(
        callId: callId,
        otherUserId: receiver.uId,
        isAudioOn: isAudioOn,
        isVideoOn: isVideoOn,
        isFrontCameraSelected: isFrontCameraSelected);
    // we navigate to the call page
    Navigator.pushNamed(
      AppRouter.navigatorKey.currentContext!,
      RoutesName.outgoingCallPage,
      arguments: receiver,
    );
  }

  Future<void> _initRenderer() async {
    await state.localRenderer.initialize();
    await state.remoteRenderer.initialize();
  }

  Future<void> _setupPeerConnection({
    required String callId,
    required String otherUserId,
    required bool isAudioOn,
    required bool isVideoOn,
    required bool isFrontCameraSelected,
  }) async {
    // we creating a new RTCPeerConnection with the specified ICE server
    // configuration, which sets up best path between peers
    // _peerConnection = await createPeerConnection({
    //   'iceServers': [
    //     {
    //       'urls': [
    //         'stun:stun1.l.google.com:19302',
    //         'stun:stun2.l.google.com:19302'
    //       ]
    //     }
    //   ]
    // });

    // listens for incoming media tracks (audio or video)
    // if it is video we set it to the remote renderer
    // _peerConnection?.onTrack = (event) {
    //   if (event.track.kind == 'video' && event.streams.isNotEmpty) {
    //     emit(state.copyWith(
    //         remoteRenderer: state.remoteRenderer
    //           ..srcObject = event.streams[0]));
    //   }
    // };

    // we create a local stream with the specified audio and video
    // _localStream = await navigator.mediaDevices.getUserMedia({
    //   'audio': isAudioOn,
    //   'video': isVideoOn
    //       ? {'facingMode': isFrontCameraSelected ? 'user' : 'environment'}
    //       : false,
    // });

    // add mediaTrack to peerConnection
    // _localStream!.getTracks().forEach((track) {
    //   log('adding track: ${track.kind}');
    //   // add local stream to peer connection
    //   _peerConnection!.addTrack(track, _localStream!);
    // });

    // set source for local video renderer
    // emit(state.copyWith(
    //     localRenderer: state.localRenderer..srcObject = _localStream));

    // if there is offer mean this is an incoming call
    if (state.currentCallOffer != null) {
      _forIncomingCall(callId);
    } else {
      _forOutgoingCall(callId: callId, receiverId: otherUserId);
    }
  }

  _forIncomingCall(String callId) async {
    // incomingDataSubscription =
    //     homeRepository.onCallDataChanged(callId).listen((data) {
    //   if (data != null) {
    //     if (data['iceCandidates'] != null) {
    //       for (Map<String, dynamic> candidateMap in data['iceCandidates']) {
    //         IceCandidateModel candidate =
    //             IceCandidateModel.fromJson(candidateMap);
    //         _peerConnection!.addCandidate(RTCIceCandidate(
    //           candidate.candidate!,
    //           candidate.sdpMid!,
    //           candidate.sdpMLineIndex!,
    //         ));
    //       }
    //     }
    //   }
    // });

    // set SDP offer as remoteDescription for peerConnection
    // await _peerConnection!.setRemoteDescription(
    //   RTCSessionDescription(
    //       state.currentCallOffer!["sdp"], state.currentCallOffer!["type"]),
    // );

    // create SDP answer
    // RTCSessionDescription answer = await _peerConnection!.createAnswer();

    // set SDP answer as localDescription for peerConnection
    // _peerConnection!.setLocalDescription(answer);

    // send SDP answer to remote peer over signalling
    //  homeRepository.sendAnswer(callId, answer.toMap());
  }

  _forOutgoingCall({required String callId, required String receiverId}) async {
    List<RTCIceCandidate> iceCandidates = [];
    // Set up a timer to close the call if no answer is received within 30 seconds
    // once ICE candidate generated by the WebRTC connection
    // which contains information about potential network paths
    // to establish the peer-to-peer connection we store it in firestore
    log('setting up onIceCandidate');
    // _peerConnection?.onIceCandidate = (candidate) {
    //   iceCandidates.add(candidate);
    // await homeRepository.addIceCandidate(callId, candidate.toMap());
    // };
    // listen for the answer from the other peer
    log(' listen for the answer from the other peer');
    outgoingDataSubscription =
        homeRepository.onCallDataChanged(callId).listen((data) async {
      if (data != null) {
        _mapCallStatusToAction(
            callStatus: data[FirebaseStrings.callStatus],
            callId: callId,
            receiverId: receiverId);
      }
    });
    log('creating offer');
    // create offer to initiate the call
    // RTCSessionDescription offer = await _peerConnection!.createOffer();
    // using this offer to set the description of the session
    // await _peerConnection!.setLocalDescription(offer);
    // store this offer in firestore
    // homeRepository.sendOffer(callId, offer.toMap());
    // log('end of outgoing call');
  }

  exitCallingPage(
      {bool waitToShowMessage = true, required bool isOutgoingCall}) async {
    // _peerConnection?.close();
    //_localStream?.dispose();
    //  state.localRenderer.srcObject = null;
    // state.remoteRenderer.srcObject = null;
    incomingDataSubscription?.cancel();
    outgoingDataSubscription?.cancel();
    incomingDataSubscription = null;
    outgoingDataSubscription = null;
    if (waitToShowMessage) {
      await Future.delayed(Duration(seconds: 3));
    }
    if (isOutgoingCall) {
      Navigator.pop(AppRouter.navigatorKey.currentContext!);
    }
    emit(CallState.initial());
  }

  Future<void> _mapCallStatusToAction(
      {required int callStatus,
      required String callId,
      required String receiverId}) async {
    switch (callStatus) {
      case 1:
        emit(state.copyWith(callStatus: 1));
        break;
      case 2:
        emit(state.copyWith(callStatus: 2));
        await homeRepository.onCallEnd(
          callId,
          UserData.currentUser!.uId,
          CallHistoryModel(
              idOfOtherUser: receiverId,
              callTime: DateTime.now(),
              callStatus: 2),
        );
        exitCallingPage(isOutgoingCall: true);
        break;
      case 3:
        emit(state.copyWith(callStatus: 3));
        await homeRepository.onCallEnd(
          callId,
          UserData.currentUser!.uId,
          CallHistoryModel(
              idOfOtherUser: receiverId,
              callTime: DateTime.now(),
              callStatus: 3),
        );
        exitCallingPage(isOutgoingCall: true);
        break;
      case 4:
        emit(state.copyWith(callStatus: 4));
        await homeRepository.onCallEnd(
          callId,
          UserData.currentUser!.uId,
          CallHistoryModel(
              idOfOtherUser: receiverId,
              callTime: DateTime.now(),
              callStatus: 4),
        );
        exitCallingPage(isOutgoingCall: true);
        break;
      default:
        break;
    }
  }

  mapCallStatusToMessage(int status) {
    switch (status) {
      case 0:
        return 'Calling...';
      case 1:
        return 'User answered';
      case 2:
        return 'call rejected';
      case 3:
        return 'User not answering';
      case 4:
        return 'User in another call';
    }
  }
}
