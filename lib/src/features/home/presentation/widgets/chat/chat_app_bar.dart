import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitchat/chitchat_app.dart';
import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key, required this.photo, required this.name});
  final String photo;
  final String name;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      shadowColor: AppColor.lighterGray,
      // leadingWidth: 25,
      titleSpacing: -6,
      actions: [
        SvgPicture.asset(
          'assets/images/svgs/phone.svg',
          width: 18.w,
          height: 18.h,
          colorFilter: ColorFilter.mode(AppColor.black, BlendMode.srcIn),
        ),
        horizontalSpace(16),
        SvgPicture.asset(
          'assets/images/svgs/video_call.svg',
          width: 24.w,
          height: 24.h,
          colorFilter: ColorFilter.mode(AppColor.black, BlendMode.srcIn),
        ),
        horizontalSpace(24),
      ],
      leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            size: 16.w,
          )),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: photo == ''
                ? const AssetImage('assets/images/noProfilePic.png')
                : CachedNetworkImageProvider(photo) as ImageProvider,
          ),
          Text(' $name'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
