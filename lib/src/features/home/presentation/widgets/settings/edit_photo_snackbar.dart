import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/assets.dart';
import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/home/presentation/cubit/settings_cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditPhotoSnackbar extends StatelessWidget {
  const EditPhotoSnackbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(5),
        _grayBar(),
        verticalSpace(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _snackBarItem(
              svg: Assets.assetsImagesSvgsCamera,
              onTap: () {
                getIt<SettingsCubit>().takePhoto(context);
              },
              name: 'Camera',
            ),
            _snackBarItem(
              svg: Assets.assetsImagesSvgsGallery,
              onTap: () {
                getIt<SettingsCubit>().selectPhotoFromGallery(context);
              },
              name: 'Gallery',
            ),
            _snackBarItem(
              svg: Assets.assetsImagesSvgsDelete,
              onTap: () {
                getIt<SettingsCubit>().deletePhoto(context);
              },
              name: 'Delete',
            ),
          ],
        ),
      ],
    );
  }

  Widget _grayBar() {
    return Container(
      width: 30.w,
      height: 3.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: AppColor.lightestGray,
      ),
    );
  }

  _snackBarItem(
      {required String svg,
      required VoidCallback onTap,
      required String name}) {
    return SizedBox(
      width: 80.w,
      height: 50.h,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            SvgPicture.asset(svg,
                width: 24,
                height: 24,
                colorFilter:
                    ColorFilter.mode(AppColor.darkerBlue, BlendMode.srcIn)),
            verticalSpace(4),
            Text(
              name,
              style: AppTextStyles.poppinsFont14DarkBlue100Medium1,
            ),
          ],
        ),
      ),
    );
  }
}
