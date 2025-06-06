import 'package:chitchat/src/core/config/injection.dart';
import 'package:chitchat/src/core/constants/assets.dart';
import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/core/models/user_data.dart';
import 'package:chitchat/src/core/widgets/app_bar_for_light_background.dart';
import 'package:chitchat/src/features/home/presentation/cubit/settings_cubit/settings_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/user_circle_avatar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/settings/user_info_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarForLightBackground(
        title: 'User Info',
        implyLeading: true,
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                verticalSpace(100),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      getIt<SettingsCubit>().showEditPhotoSnackbar(context);
                    },
                    child: UserCircleAvatar(
                      size: 152,
                      userPhoto: UserData.currentUser?.photo,
                    ),
                  ),
                ),
                verticalSpace(20),
                TextButton(
                    onPressed: () {
                      getIt<SettingsCubit>().showEditPhotoSnackbar(context);
                    },
                    child: Text('Change Profile Photo',
                        style: TextStyle(color: AppColor.darkBlue))),
                verticalSpace(30),
                UserInfoItems(
                    title: 'Name',
                    svgIcon: Assets.assetsImagesSvgsUser,
                    subtitle: UserData.currentUser?.name ?? 'No Name',
                    onTap: () {
                      getIt<SettingsCubit>().updateName(context: context);
                    }),
                verticalSpace(30),
                UserInfoItems(
                  title: 'About',
                  svgIcon: Assets.assetsImagesSvgsAbout,
                  subtitle: UserData.currentUser?.bio == null ||
                          UserData.currentUser?.bio == ''
                      ? 'No Bio'
                      : UserData.currentUser!.bio,
                  onTap: () {
                    getIt<SettingsCubit>().updateBio(context: context);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
