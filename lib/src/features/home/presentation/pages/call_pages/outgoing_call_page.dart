import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/networking/models/user_call_model.dart';
import 'package:chitchat/src/core/widgets/app_bar_for_dark_background.dart';
import 'package:chitchat/src/core/widgets/general_background_wrapper.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/outgoing/outgoing_call_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/outgoing_call/outgoing_dialing.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/video_call.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/voice_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OutgoingCallPage extends StatelessWidget {
  final UserCallModel receiver;
  const OutgoingCallPage({
    super.key,
    required this.receiver,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarForDarkBackground(),
      extendBodyBehindAppBar: true,
      body: GeneralBackgroundWrapper(
        child: SafeArea(
          child: BlocBuilder<OutgoingCallCubit, OutgoingCallState>(
            builder: (context, state) {
              // if (state.callStatus==1) mean user accepted the call
              // so we show rtc call page
              return state.callStatus == 1
                  ? state.isVideoOnUI
                      ? VideoCall(state: state, receiver: receiver)
                      : VoiceCall(
                          name: receiver.name,
                          photo: receiver.photo,
                          isIncomingCall: false,
                          closeCall: () async {
                            await getIt<OutgoingCallCubit>()
                                .exitCall(otherUserData: receiver);
                          },
                        )
                  : OutgoingDialing(receiver: receiver, state: state);
            },
          ),
        ),
      ),
    );
  }
}
