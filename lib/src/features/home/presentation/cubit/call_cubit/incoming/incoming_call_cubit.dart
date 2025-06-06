import 'dart:async';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:chitchat/src/core/constants/audio_assets.dart';
import 'package:chitchat/src/core/constants/strings.dart';
import 'package:chitchat/src/core/models/user_data.dart';
import 'package:chitchat/src/core/networking/models/call_history_model.dart';
import 'package:chitchat/src/core/networking/models/ice_candidate_model.dart';
import 'package:chitchat/src/core/networking/models/user_call_model.dart';
import 'package:chitchat/src/core/networking/network_exceptions.dart';
import 'package:chitchat/src/features/home/data/repo/repo.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/webrtc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
part 'incoming_call_state.dart';

class IncomingCallCubit extends Cubit<IncomingCallState> {
  IncomingCallCubit({required this.homeRepository, required this.webrtc})
      : super(IncomingCallState.initial());
  HomeRepository homeRepository;
  Webrtc webrtc;

  final player = AudioPlayer();
  StreamSubscription? onNewCallCreatedSubscription;
  StreamSubscription? incomingCallDeleted;
  StreamSubscription? incomingDataSubscription;
  String callId = '';
  Map<String, dynamic> offer = {};
  bool callStarted = false;
  bool saveCallHistory = false;

  void listenForIncomingCall() async {
    // listen for incoming calls
    try {
      onNewCallCreatedSubscription =
          homeRepository.onNewCallCreated().listen((data) async {
        // if the receiverId is the current user id show this call to user
        if (data[FirebaseStrings.receiverId] == UserData.currentUser!.uId &&
            data[FirebaseStrings.offer] != null &&
            !callStarted) {
          callStarted = true;
          // if the current call offer is null mean the user is not in another call
          offer = data[FirebaseStrings.offer];
          callId = data[FirebaseStrings.callId];
          // check call type and change state depend on it
          if (data[FirebaseStrings.callType] == 'video') {
            emit(state.copyWith(
                isVideoOn: true,
                isFrontCameraSelected: true,
                isVideoOnUI: true));
          } else {
            emit(state.copyWith(
                isVideoOn: false,
                isFrontCameraSelected: false,
                isVideoOnUI: false));
          }
          if (!state.userInCall) {
            await webrtc.initRenderers();
            await webrtc.setupPeerConnection(
              callId: callId,
              isAudioOn: state.isAudioOn,
              isVideoOn: state.isVideoOn,
              isFrontCameraSelected: state.isFrontCameraSelected,
            );

            _thereIsIncomingCall(
                callerData:
                    UserCallModel.fromJson(data[FirebaseStrings.callerData]),
                callType: data[FirebaseStrings.callType]);
          } else {
            // user is in another call
            // so we decline the call with status code 4
            await closeIncomingCall(
                responseCode: 4,
                callType: data[FirebaseStrings.callType],
                callerData:
                    UserCallModel.fromJson(data[FirebaseStrings.callerData]));
          }
        }
      });
    } catch (e) {
      log(e.toString());
      NetworkExceptions.showErrorDialog(e);
    }
  }

  _thereIsIncomingCall({
    required UserCallModel callerData,
    required String callType,
  }) async {
    // show the incoming call page to the user
    emit(state.copyWith(
      userInCall: true,
      callerData: callerData,
      responseCode: null,
    ));
    //todo start playing sound
    await player.play(AssetSource(AudioAssets.incomingCall));
    await player.setReleaseMode(ReleaseMode.loop);
    // subscribe new stream to check if caller canceled the call
    // if caller ended call status code 5
    incomingCallDeleted =
        homeRepository.onCallDeleted(callId).listen((data) async {
      if (data != null && data && !saveCallHistory) {
        await closeIncomingCall(
          responseCode: 5,
          callType: callType,
          callerData: callerData,
        );
      }
    });
    // start a timer for 30 seconds
    bool callHandled = false;
    // set a timer for 20 seconds if if the user did
    // not decide within 20 seconds, decline the call
    // user not response status code 3
    Timer timer = Timer(Duration(seconds: 20), () async {
      if (!callHandled) {
        await closeIncomingCall(
          responseCode: 3,
          callType: callType,
          callerData: callerData,
        );
      }
    });
    // check  user response every 1 second
    while (!callHandled) {
      await Future.delayed(Duration(seconds: 1));
      if (state.responseCode != 0) {
        callHandled = true;
        timer.cancel();
        // depend on user to accept or decline the call
        if (state.responseCode == 1) {
          player.stop();
          emit(
            state.copyWith(
              localRenderer: webrtc.localRenderer,
              remoteRenderer: webrtc.remoteRenderer,
            ),
          );
          // we accept the call
          await _acceptIncomingCall();
          await homeRepository.updateCallStatus(callId, 1);
          // save call in user history
        } else {
          //user decide to decline the call status code 2
          await closeIncomingCall(
            responseCode: 2,
            callType: callType,
            callerData: callerData,
          );
        }
      }
    }
  }

  _acceptIncomingCall() async {
    try {
      await homeRepository.updateUserLastSeen(uId: UserData.currentUser!.uId);
      incomingDataSubscription =
          homeRepository.onCallDataChanged(callId).listen((data) async {
        if (data != null) {
          if (data[FirebaseStrings.iceCandidates] != null) {
            for (Map<String, dynamic> candidateMap
                in data[FirebaseStrings.iceCandidates]) {
              IceCandidateModel candidate =
                  IceCandidateModel.fromJson(candidateMap);
              webrtc.peerConnection!.addCandidate(RTCIceCandidate(
                candidate.candidate!,
                candidate.sdpMid!,
                candidate.sdpMLineIndex!,
              ));
            }
          }
        }
      });

      // set SDP offer as remoteDescription for peerConnection
      await webrtc.peerConnection!.setRemoteDescription(
        RTCSessionDescription(offer["sdp"], offer["type"]),
      );
      // create SDP answer
      RTCSessionDescription answer =
          await webrtc.peerConnection!.createAnswer();
      // set SDP answer as localDescription for peerConnection
      // await webrtc.peerConnection!.setLocalDescription(answer);
      if (webrtc.peerConnection!.signalingState !=
          RTCSignalingState.RTCSignalingStateStable) {
        await webrtc.peerConnection!.setLocalDescription(answer);
      } else {
        log('Skipping setLocalDescription: Connection is already stable.');
      }
      // send SDP answer to remote peer over signalling
      await homeRepository.sendAnswer(callId, answer.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  handelIncomingCall({required int responseCode}) {
    if (responseCode == 6) {
      closeIncomingCall(
          responseCode: responseCode,
          callerData: state.callerData!,
          callType: state.isVideoOn ? 'video' : 'audio');
    } else {
      emit(state.copyWith(responseCode: responseCode));
    }
  }

  closeIncomingCall(
      {required int responseCode,
      required UserCallModel callerData,
      required String callType}) async {
    try {
      player.stop();
      await homeRepository.updateUserLastSeen(uId: UserData.currentUser!.uId);
      // if call status is 5 mean user deleted the call from firebase
      //so we can't update call status in firebase
      if (responseCode != 5) {
        await homeRepository.updateCallStatus(callId, responseCode);
      }
      log('saving call history with status code $responseCode');
      if (!saveCallHistory) {
        // save call in user history
        saveCallHistory = true;
        // add data to call history for caller user
        await homeRepository.addCallToUserHistory(
          userID: UserData.currentUser!.uId,
          callData: CallHistoryModel(
            incoming: true,
            callType: callType,
            userData: callerData,
            callTime: DateTime.now().toString(),
            callStatus: responseCode,
          ),
        );
      }
      // if status code is 4 mean user in aborter call so we
      //can't close calling page
      if (responseCode != 4) {
        exitCallingPage();
      }
      callStarted = false;
    } catch (error) {
      log("the error is $error", error: error);
      NetworkExceptions.showErrorDialog(error);
    }
  }

  toggleMic() {
    // change status
    emit(state.copyWith(isAudioOn: !state.isAudioOn));
    log('${state.isAudioOn}');
    // enable or disable audio track
    webrtc.toggleMicRtc(state.isAudioOn);
  }

  toggleCamera() {
    // change status
    emit(state.copyWith(isVideoOn: !state.isVideoOn));
    // enable or disable video track
    webrtc.toggleCameraRtc(state.isAudioOn);
  }

  switchCamera() {
    emit(state.copyWith(isFrontCameraSelected: !state.isFrontCameraSelected));
    // change status
    webrtc.switchCameraRtc();
  }

  exitCallingPage() async {
    // we stop all streams
    incomingCallDeleted?.cancel();
    incomingCallDeleted = null;
    incomingDataSubscription?.cancel();
    incomingDataSubscription = null;
    // we stop and remove the sound
    // player.dispose();
    await webrtc.dispose();
    // we reset the state
    callId = '';
    emit(
      state.reset(),
    );
  }
}
