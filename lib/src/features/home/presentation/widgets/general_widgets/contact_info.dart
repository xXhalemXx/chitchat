import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitchat/src/core/constants/assets.dart';
import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo(
      {super.key,
      required this.bio,
      required this.name,
      required this.userPhoto,
      this.onTap});
  final String name;
  final String bio;
  final String userPhoto;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          _avatarImage(userPhoto: userPhoto),
          horizontalSpace(12.w),
          _nameAndBio(name: name, bio: bio),
        ],
      ),
    );
  }

  Widget _avatarImage({required String userPhoto}) {
    return Stack(
      children: [
        Container(
          width: 52.w,
          height: 52.h,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: CircleAvatar(
            backgroundImage: userPhoto == ''
                ? const AssetImage(Assets.assetsImagesNoProfilePic)
                : CachedNetworkImageProvider(userPhoto) as ImageProvider,
          ),
        ),
      ],
    );
  }

  Widget _nameAndBio({
    required String name,
    required String bio,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTextStyles.poppinsFont18Black100Medium1,
        ),
        bio.isNotEmpty ? verticalSpace(6.h) : const SizedBox.shrink(),
        bio.isNotEmpty
            ? Text(
                bio,
                style: AppTextStyles.poppinsFont12Gray50Regular1,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
