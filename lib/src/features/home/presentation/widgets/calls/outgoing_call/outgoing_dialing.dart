import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/core/networking/models/user_call_model.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/outgoing/outgoing_call_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/action_button.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/actions_bottom_bar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';

class OutgoingDialing extends StatelessWidget {
  const OutgoingDialing(
      {super.key, required this.receiver, required this.state});
  final UserCallModel receiver;
  final OutgoingCallState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        UserCircleAvatar(size: 209, userPhoto: receiver.photo),
        verticalSpace(10),
        Text(receiver.name, style: AppTextStyles.poppinsFont20White100Medium1),
        verticalSpace(10),
        Text(
          getIt<OutgoingCallCubit>().mapCallStatusToMessage(state.callStatus),
          textAlign: TextAlign.center,
          style: AppTextStyles.poppinsFont14White100Regular1,
        ),
        const Spacer(),
        ActionsBottomBar(buttons: [
          ActionButton(
            circleColor: AppColor.black.withAlpha(100),
            icon: state.isAudioOn ? Icons.mic_off : Icons.mic,
            iconColor: AppColor.white,
            onTap: () async {
              getIt<OutgoingCallCubit>().toggleMic();
            },
          ),
          ActionButton(
            circleColor: AppColor.red,
            icon: Icons.call_end,
            iconColor: AppColor.white,
            onTap: () async {
              await getIt<OutgoingCallCubit>()
                  .exitCall(otherUserData: receiver);
            },
          ),
        ]),
        verticalSpace(100),
      ],
    );
  }
}
