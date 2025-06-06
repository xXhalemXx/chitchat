import 'package:chitchat/src/core/config/injection.dart';
import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/networking/models/user_call_model.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/incoming/incoming_call_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/outgoing/outgoing_call_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCall extends StatelessWidget {
  const VideoCall({super.key, this.receiver, required this.state})
      : assert(
          state is IncomingCallState || state is OutgoingCallState,
          state is OutgoingCallState && receiver != null,
        );
  final dynamic state;
  final UserCallModel? receiver;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(children: [
            RTCVideoView(
              state.remoteRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
            Positioned(
              right: 20.w,
              bottom: 20.h,
              child: SizedBox(
                height: 150.h,
                width: 120.w,
                child: RTCVideoView(
                  state.localRenderer,
                  mirror: state.isFrontCameraSelected,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                ),
              ),
            )
          ]),
        ),
        Container(
          color: AppColor.black,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.cameraswitch,
                    color: AppColor.white,
                  ),
                  onPressed: () {
                    if (state is OutgoingCallState) {
                      getIt<OutgoingCallCubit>().switchCamera();
                    } else {
                      getIt<IncomingCallCubit>().switchCamera();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    state.isVideoOn ? Icons.videocam_off : Icons.videocam,
                    color: AppColor.white,
                  ),
                  onPressed: () {
                    if (state is IncomingCallState) {
                      getIt<IncomingCallCubit>().toggleCamera();
                    } else {
                      getIt<OutgoingCallCubit>().toggleCamera();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    state.isAudioOn ? Icons.mic_off : Icons.mic,
                    color: AppColor.white,
                  ),
                  onPressed: () {
                    if (state is OutgoingCallState) {
                      getIt<OutgoingCallCubit>().toggleMic();
                    } else {
                      getIt<IncomingCallCubit>().toggleMic();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.call_end,
                    color: AppColor.red.withAlpha(120),
                  ),
                  iconSize: 30,
                  onPressed: () {
                    if (state is IncomingCallState) {
                      getIt<IncomingCallCubit>().handelIncomingCall(
                        responseCode: 6,
                      );
                    } else if (state is OutgoingCallState) {
                      getIt<OutgoingCallCubit>()
                          .exitCall(otherUserData: receiver!);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
