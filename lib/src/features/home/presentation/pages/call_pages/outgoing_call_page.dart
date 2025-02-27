import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/assets.dart';
import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/call_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutgoingCallPage extends StatelessWidget {
  final UserModel receiver;
  const OutgoingCallPage({
    super.key,
    required this.receiver,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _boxDecorationFun(),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              UserCircleAvatar(size: 209, userPhoto: receiver.photo),
              verticalSpace(10),
              Text(receiver.name,
                  style: AppTextStyles.poppinsFont20White100Medium1),
              verticalSpace(10),
              BlocBuilder<CallCubit, CallState>(
                builder: (context, state) {
                  return Text(
                    getIt<CallCubit>().mapCallStatusToMessage(state.callStatus),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.poppinsFont14White100Regular1,
                  );
                },
              ),
              const Spacer(),
              _actionsBottomBar(receiverId: receiver.uId),
              verticalSpace(30),
            ],
          ),
        ),
      ),
    );
  }

  _actionsBottomBar({required String receiverId}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 70.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _actionButton(
            receiverId: receiverId,
            circleColor: AppColor.black.withOpacity(0.5),
            icon: Icons.mic_off,
            iconColor: AppColor.white,
            //  onTap: getIt<CallCubit>().exitOutgoingCall(receiverId: receiverId),
          ),
          _actionButton(
            receiverId: receiverId,
            circleColor: AppColor.red,
            icon: Icons.call_end,
            iconColor: AppColor.white,
            //  onTap: getIt<CallCubit>().exitOutgoingCall(receiverId: receiverId),
          ),
        ],
      ),
    );
  }

  _actionButton({
    required String receiverId,
    required Color circleColor,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor,
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }

  BoxDecoration _boxDecorationFun() {
    return const BoxDecoration(
      image: DecorationImage(
          image: AssetImage(Assets.assetsImagesDashboardBackground),
          fit: BoxFit.cover),
    );
  }
}
