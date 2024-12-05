import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return _chatEntity();
      },
    );
  }

  _chatEntity() {
    return Padding(
      padding: EdgeInsets.only(left: 24.0.w, bottom: 30.h, right: 24.w),
      child: SizedBox(
        height: 52.h,
        child: Slidable(
          direction: Axis.horizontal,
          endActionPane: _endActionPane(),
          child: Row(
            children: [
              _avatarImage(),
              horizontalSpace(12.w),
              _avatarNameAndLastMessage(),
              const Spacer(),
              _timeAndUnreadMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatarImage() {
    return Stack(
      children: [
        Container(
          width: 52.w,
          height: 52.h,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: CircleAvatar(
            child: Image.asset('assets/images/person_2.png'),
          ),
        ),
        Positioned(
          bottom: 3.h,
          right: 3.w,
          child: Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.green,
            ),
          ),
        ),
      ],
    );
  }

  Widget _avatarNameAndLastMessage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alex Linderson',
          style: AppTextStyles.poppinsFont20Black100Medium1,
        ),
        verticalSpace(6.h),
        Text(
          'How are you today?',
          style: AppTextStyles.poppinsFont12Gray50Regular1,
        )
      ],
    );
  }

  Widget _timeAndUnreadMessage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '2 min ago',
          style: AppTextStyles.poppinsFont12Gray50Light1,
        ),
        verticalSpace(9.h),
        Container(
          width: 22.w,
          height: 22.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.red,
          ),
          child: Center(
            child: Text(
              '3',
              style: AppTextStyles.poppinsFont12White100Black1,
            ),
          ),
        ),
      ],
    );
  }

  ActionPane _endActionPane() {
    return ActionPane(
      extentRatio: 0.35,
      motion: const ScrollMotion(),
      children: [
        horizontalSpace(16.w),
        _actionPaneButton(
            onTap: () {
              print('tap bill');
            },
            svgName: 'assets/images/svgs/bill.svg',
            backgroundColor: AppColor.black),
        horizontalSpace(16.w),
        _actionPaneButton(
            onTap: () {
              print('tap delete');
            },
            svgName: 'assets/images/svgs/trash.svg',
            backgroundColor: AppColor.red),
      ],
    );
  }

  Widget _actionPaneButton(
      {required VoidCallback onTap,
      required String svgName,
      required Color backgroundColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.h,
        decoration:
            BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
        child: Center(
          child: SvgPicture.asset(
            svgName,
          ),
        ),
      ),
    );
  }
}
