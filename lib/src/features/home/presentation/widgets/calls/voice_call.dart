import 'package:chitchat/src/core/config/injection.dart';
import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/incoming/incoming_call_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/outgoing/outgoing_call_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/action_button.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/actions_bottom_bar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';

class VoiceCall extends StatelessWidget {
  const VoiceCall({
    super.key,
    required this.name,
    required this.photo,
    required this.isIncomingCall,
    required this.closeCall,
  });
  final String name;
  final String photo;
  final bool isIncomingCall;
  final Future<void> Function() closeCall;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        UserCircleAvatar(size: 209, userPhoto: photo),
        verticalSpace(10),
        Text(name, style: AppTextStyles.poppinsFont20White100Medium1),
        verticalSpace(10),
        Text(
          'Connected',
          textAlign: TextAlign.center,
          style: AppTextStyles.poppinsFont14White100Regular1,
        ),
        const Spacer(),
        ActionsBottomBar(buttons: [
          ActionButton(
            circleColor: AppColor.black.withAlpha(100),
            icon: isIncomingCall
                ? getIt<IncomingCallCubit>().state.isAudioOn
                    ? Icons.mic_off
                    : Icons.mic
                : getIt<OutgoingCallCubit>().state.isAudioOn
                    ? Icons.mic_off
                    : Icons.mic,
            iconColor: AppColor.white,
            onTap: () async {
              if (isIncomingCall) {
                getIt<IncomingCallCubit>().toggleMic();
              } else {
                getIt<OutgoingCallCubit>().toggleMic();
              }
            },
          ),
          ActionButton(
            circleColor: AppColor.red,
            icon: Icons.call_end,
            iconColor: AppColor.white,
            onTap: closeCall,
          ),
        ]),
        verticalSpace(100),
      ],
    );
  }
}
