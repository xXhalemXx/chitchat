import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/home_cubit.dart';
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
              getIt<HomeCubit>().currentUser.name,
              style: AppTextStyles.poppinsFont14White100Regular1,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _userImageWithAdd() {
    String userPhoto = getIt<HomeCubit>().currentUser.photo;

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
            child: Container(
              width: 52.w,
              height: 52.h,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: CircleAvatar(
                backgroundImage: userPhoto == ''
                    ? const AssetImage('assets/images/noProfilePic.png')
                    : CachedNetworkImageProvider(userPhoto) as ImageProvider,
              ),
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
