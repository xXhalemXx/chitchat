import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitchat/src/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserCircleAvatar extends StatelessWidget {
  const UserCircleAvatar({super.key, this.userPhoto, required this.size});
  final String? userPhoto;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.h,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: CircleAvatar(
        backgroundImage: userPhoto == '' || userPhoto == null
            ? const AssetImage(Assets.assetsImagesNoProfilePic)
            : CachedNetworkImageProvider(userPhoto!) as ImageProvider,
      ),
    );
  }
}
