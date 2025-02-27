import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/core/models/user_data.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusCircles extends StatelessWidget {
  const StatusCircles({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 21.0.w),
      child: SizedBox(
        height: 82.h,
        width: double.infinity,
        child: Align(
          alignment: Alignment.centerLeft,
          child: _circleWithName(),
        ),
      ),
    );
  }

  Widget _circleWithName() {
    return Container(
      margin: EdgeInsets.only(right: 12.0.w),
      width: 58.w,
      height: 82.h,
      child: Column(
        children: [
          _userImageWithAdd(),
          verticalSpace(6.h),
          Expanded(
            child: Text(
              UserData.currentUser!.name,
              style: AppTextStyles.poppinsFont14White100Regular1,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _userImageWithAdd() {
    String userPhoto = UserData.currentUser!.photo;

    return Stack(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: AppColor.white.withOpacity(0.6), width: 1.50.w)),
          child: Center(
            child: UserCircleAvatar(
              userPhoto: userPhoto,
              size: 52,
            ),
          ),
        ),
        Positioned(
          bottom: 2.h,
          right: 0.w,
          child: Container(
            width: 16.w,
            height: 16.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.white,
              border: Border.all(color: AppColor.black, width: 1.2.w),
            ),
            child: Center(
              child: Icon(
                Icons.add,
                size: 10.w,
                color: AppColor.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
