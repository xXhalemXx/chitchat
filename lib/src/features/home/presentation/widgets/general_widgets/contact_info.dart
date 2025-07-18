import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';

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
          UserCircleAvatar(
            userPhoto: userPhoto,
            size: 52,
          ),
          horizontalSpace(12),
          _nameAndBio(name: name, bio: bio),
        ],
      ),
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
        bio.isNotEmpty ? verticalSpace(6) : const SizedBox.shrink(),
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
