import 'package:chitchat/src/core/config/injection.dart';
import 'package:chitchat/src/core/constants/assets.dart';
import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/core/models/user_data.dart';
import 'package:chitchat/src/features/home/presentation/cubit/settings_cubit/settings_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return _accountDetails(context);
            },
          ),
          Divider(
            color: AppColor.moreLightGray,
          ),
          _settingsItem(
              title: 'Account',
              svgName: Assets.assetsImagesSvgsKey,
              description: 'Privacy, security, change number',
              onTap: () {}),
          _settingsItem(
              title: 'Chat',
              svgName: Assets.assetsImagesSvgsMessage,
              description: 'Chat history, theme, wallpapers',
              onTap: () {}),
          _settingsItem(
              title: 'Notifications',
              svgName: Assets.assetsImagesSvgsNotifications,
              description: 'Messages, group and others',
              onTap: () {}),
          _settingsItem(
              title: 'Help',
              svgName: Assets.assetsImagesSvgsHelp,
              description: 'Help center, contact us, privacy policy',
              onTap: () {}),
          _settingsItem(
              title: 'Storage and data',
              svgName: Assets.assetsImagesSvgsData,
              description: 'Network usage, storage usage',
              onTap: () {}),
        ],
      ),
    );
  }

  Widget _accountDetails(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getIt<SettingsCubit>().navigateToProfileInfo(context);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 16.0.w, bottom: 10.h, right: 24.w),
        child: Row(children: [
          UserCircleAvatar(
            size: 60,
            userPhoto: UserData.currentUser?.photo,
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  UserData.currentUser?.name ?? '',
                  style: AppTextStyles.poppinsFont20Black100Bold1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(9),
                Text(
                  UserData.currentUser?.bio == null ||
                          UserData.currentUser?.bio == ''
                      ? 'tap to set status'
                      : UserData.currentUser!.bio,
                  maxLines: 1,
                  style: AppTextStyles.poppinsFont12Gray100Light1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: SvgPicture.asset(Assets.assetsImagesSvgsQrCode),
          )
        ]),
      ),
    );
  }

  _settingsItem(
      {required String title,
      required String svgName,
      String? description,
      required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.only(left: 24.0.w, bottom: 30.h, right: 24.w),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.lightBlue,
              ),
              child: Center(
                child: SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: SvgPicture.asset(
                    svgName,
                    colorFilter: ColorFilter.mode(
                        AppColor.gray.withAlpha(150), BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            horizontalSpace(12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: AppTextStyles.poppinsFont16Black100Medium1),
              verticalSpace(5),
              description == null
                  ? const SizedBox.shrink()
                  : Text(description,
                      style: AppTextStyles.poppinsFont12Gray50Light1),
            ])
          ],
        ),
      ),
    );
  }
}
