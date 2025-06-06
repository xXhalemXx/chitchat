import 'dart:developer';

import 'package:flutter_webrtc/flutter_webrtc.dart';

class Webrtc {
  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  final RTCVideoRenderer localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer remoteRenderer = RTCVideoRenderer();

  /// this function to initialize local and remote renderer
  Future<void> initRenderers() async {
    log("renderer re init *********************************************");
    await localRenderer.initialize();
    await remoteRenderer.initialize();
  }

  /// this function to configure peer connection
  /// and set local and remote renderer
  Future<void> setupPeerConnection({
    required String callId,
    required bool isAudioOn,
    required bool isVideoOn,
    required bool isFrontCameraSelected,
  }) async {
    /// we creating a new RTCPeerConnection with the specified ICE server
    /// configuration, which sets up best path between peers
    peerConnection = await createPeerConnection({
      'iceServers': [
        {
          'urls': [
            'stun:stun1.l.google.com:19302',
            'stun:stun2.l.google.com:19302'
          ]
        }
      ]
    });

    /// listens for incoming media tracks (audio or video)
    /// if it is video we set it to the remote renderer
    peerConnection?.onTrack = (event) {
      remoteRenderer.srcObject = event.streams[0];
    };

    ///we create a local stream with the specified audio and video
    localStream = await navigator.mediaDevices.getUserMedia({
      'audio': isAudioOn,
      'video': isVideoOn
          ? {'facingMode': isFrontCameraSelected ? 'user' : 'environment'}
          : false,
    });

    ///add mediaTrack to peerConnection
    localStream!.getTracks().forEach((track) {
      // add local stream to peer connection
      peerConnection!.addTrack(track, localStream!);
    });

    // set source for local video renderer
    localRenderer.srcObject = localStream;
  }

  toggleMicRtc(bool isEnabled) {
    localStream?.getAudioTracks().forEach((track) {
      track.enabled = isEnabled;
    });
  }

  toggleCameraRtc(bool isEnabled) {
    localStream?.getVideoTracks().forEach((track) {
      track.enabled = isEnabled;
    });
  }

  switchCameraRtc() {
    localStream?.getVideoTracks().forEach((track) {
      Helper.switchCamera(track);
      // track.switchCamera();
    });
  }

  dispose() async {
    await peerConnection?.close();
    localStream?.getTracks().forEach((track) => track.stop());
    localRenderer.srcObject = null;
    remoteRenderer.srcObject = null;
    // await localRenderer.dispose();
    // await remoteRenderer.dispose();
  }
}
