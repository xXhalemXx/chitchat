import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _accountDetails(),
          Divider(
            color: AppColor.moreLightGray,
          ),
          verticalSpace(25.h),
          _settingsItem(
              title: 'Account',
              svgName: 'key',
              description: 'Privacy, security, change number',
              onTap: () {}),
          _settingsItem(
              title: 'Chat',
              svgName: 'message',
              description: 'Chat history, theme, wallpapers',
              onTap: () {}),
          _settingsItem(
              title: 'Notifications',
              svgName: 'notifications',
              description: 'Messages, group and others',
              onTap: () {}),
          _settingsItem(
              title: 'Help',
              svgName: 'help',
              description: 'Help center, contact us, privacy policy',
              onTap: () {}),
          _settingsItem(
              title: 'Storage and data',
              svgName: 'data',
              description: 'Network usage, storage usage',
              onTap: () {}),
          _settingsItem(
            title: 'Invite a friend',
            svgName: 'users',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  _accountDetails() {
    return Padding(
      padding: EdgeInsets.only(left: 24.0.w, bottom: 20.h, right: 24.w),
      child: Row(children: [
        _avatarImage(),
        horizontalSpace(12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nazrul Islam',
                style: AppTextStyles.poppinsFont20Black100Bold1),
            verticalSpace(9.h),
            Text('Never give up 💪',
                style: AppTextStyles.poppinsFont12Gray100Light1),
          ],
        ),
        const Spacer(),
        SizedBox(
          width: 24.w,
          height: 24.h,
          child: SvgPicture.asset('assets/images/svgs/qr_code.svg'),
        )
      ]),
    );
  }

  Widget _avatarImage() {
    return Stack(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: CircleAvatar(
            child: Image.asset('assets/images/person_1.png'),
          ),
        ),
      ],
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
                    'assets/images/svgs/$svgName.svg',
                  ),
                ),
              ),
            ),
            horizontalSpace(12.w),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: AppTextStyles.poppinsFont16Black100Medium1),
              verticalSpace(5.h),
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
