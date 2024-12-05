import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar(
      {super.key, required this.onTabTapped, required this.currentIndex});
  final int currentIndex;
  final Function(int) onTabTapped;

  @override
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColor.white,
      elevation: 0,
      selectedItemColor: AppColor.darkBlue,
      //unselectedItemColor: AppColor.gray.withOpacity(0.39),
      selectedLabelStyle: AppTextStyles.poppinsFont16DarkBlue100Medium1,
      unselectedLabelStyle: AppTextStyles.poppinsFont16gray39Regular1,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/svgs/message.svg',
            width: 26.w,
            height: 26.h,
          ),
          activeIcon: SvgPicture.asset(
            'assets/images/svgs/message_blue.svg',
            width: 26.w,
            height: 26.h,
          ),
          label: 'Message',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/svgs/calls.svg',
            width: 26.w,
            height: 26.h,
          ),
          label: 'Calls',
          activeIcon: SvgPicture.asset(
            'assets/images/svgs/calls_blue.svg',
            width: 26.w,
            height: 26.h,
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/svgs/contacts.svg',
            width: 26.w,
            height: 26.h,
          ),
          label: 'Contacts',
          activeIcon: SvgPicture.asset(
            'assets/images/svgs/contacts_blue.svg',
            width: 26.w,
            height: 26.h,
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/svgs/settings.svg',
            width: 26.w,
            height: 26.h,
          ),
          label: 'Settings',
          activeIcon: SvgPicture.asset(
            'assets/images/svgs/settings_blue.svg',
            width: 26.w,
            height: 26.h,
          ),
        ),
      ],
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        onTabTapped(index);
      },
    );
  }
}



// SvgPicture.asset(
//             'assets/images/svgs/message.svg',
//             width: 26.w,
//             height: 26.h,
//             colorFilter: _currentIndex == 0
//                 ? ColorFilter.mode(AppColor.darkerBlue, BlendMode)
//                 : ColorFilter.mode(
//                     AppColor.gray.withOpacity(0.39), BlendMode.srcIn),
//           )