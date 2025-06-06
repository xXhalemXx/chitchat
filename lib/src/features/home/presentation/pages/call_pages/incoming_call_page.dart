import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/widgets/app_bar_for_dark_background.dart';
import 'package:chitchat/src/core/widgets/general_background_wrapper.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/incoming/incoming_call_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/incoming_call/incoming_call.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/video_call.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/voice_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomingCallPage extends StatelessWidget {
  const IncomingCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarForDarkBackground(),
      extendBodyBehindAppBar: true,
      body: GeneralBackgroundWrapper(
        child: SafeArea(
          child: BlocBuilder<IncomingCallCubit, IncomingCallState>(
            builder: (context, state) {
              return state.responseCode == 1
                  ? state.isVideoOnUI
                      ? VideoCall(
                          state: state,
                        )
                      : VoiceCall(
                          name: state.callerData?.name ?? '',
                          photo: state.callerData?.photo ?? '',
                          isIncomingCall: true,
                          closeCall: () async {
                            await getIt<IncomingCallCubit>()
                                .handelIncomingCall(responseCode: 6);
                          },
                        )
                  : IncomingCall(state: state);
            },
          ),
        ),
      ),
    );
  }
}
