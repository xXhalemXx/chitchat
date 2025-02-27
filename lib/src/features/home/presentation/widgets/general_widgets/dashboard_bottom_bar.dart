import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/assets.dart';
import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:chitchat/src/features/home/presentation/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DashboardBottomBar extends StatelessWidget {
  const DashboardBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return BottomNavigationBar(
          backgroundColor: AppColor.white,
          elevation: 0,
          //selectedItemColor: AppColor.darkBlue,
          selectedLabelStyle: AppTextStyles.poppinsFont16DarkBlue100Medium1,
          unselectedLabelStyle: AppTextStyles.poppinsFont16gray39Regular1,
          items: [
            _bottomNavBarItem(
              svgPath: Assets.assetsImagesSvgsMessage,
              label: 'Message',
              isSelected: state.currentIndex == 0,
            ),
            _bottomNavBarItem(
              svgPath: Assets.assetsImagesSvgsCalls,
              label: 'Calls',
              isSelected: state.currentIndex == 1,
            ),
            _bottomNavBarItem(
              svgPath: Assets.assetsImagesSvgsContacts,
              label: 'Contacts',
              isSelected: state.currentIndex == 2,
            ),
            _bottomNavBarItem(
              svgPath: Assets.assetsImagesSvgsSettings,
              label: 'Settings',
              isSelected: state.currentIndex == 3,
            ),
          ],
          currentIndex: state.currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            getIt<DashboardCubit>().changePage(index);
          },
        );
      },
    );
  }

  BottomNavigationBarItem _bottomNavBarItem(
      {required String svgPath,
      required String label,
      required bool isSelected}) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        svgPath,
        width: 26.w,
        height: 26.h,
        colorFilter: ColorFilter.mode(
            isSelected ? AppColor.darkerBlue : AppColor.gray, BlendMode.srcIn),
      ),
      label: label,
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