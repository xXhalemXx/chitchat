import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/incoming/incoming_call_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/action_button.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/actions_bottom_bar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';

class IncomingCall extends StatelessWidget {
  const IncomingCall({super.key, required this.state});
  final IncomingCallState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        UserCircleAvatar(size: 209, userPhoto: state.callerData?.photo ?? ''),
        verticalSpace(10),
        Text(state.callerData?.name ?? '',
            style: AppTextStyles.poppinsFont20White100Medium1),
        verticalSpace(10),
        Text(
          state.isVideoOn ? 'Incoming Video call' : 'Incoming Audio call',
          textAlign: TextAlign.center,
          style: AppTextStyles.poppinsFont14White100Regular1,
        ),
        const Spacer(),
        ActionsBottomBar(buttons: [
          ActionButton(
            circleColor: AppColor.green,
            icon: Icons.call,
            iconColor: AppColor.white,
            onTap: () async {
              await getIt<IncomingCallCubit>().handelIncomingCall(
                responseCode: 1,
              );
            },
          ),
          ActionButton(
            circleColor: AppColor.red,
            icon: Icons.call_end,
            iconColor: AppColor.white,
            onTap: () async {
              await getIt<IncomingCallCubit>()
                  .handelIncomingCall(responseCode: 2);
            },
          ),
        ]),
        verticalSpace(100),
      ],
    );
  }
}
