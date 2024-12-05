import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CallDetails extends StatelessWidget {
  const CallDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return _callsEntity(index: index);
      },
    );
  }

  _callsEntity({required int index}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: 24.0.w,
              bottom: 20.h,
              top: index == 0 ? 0.h : 20.h,
              right: 24.w),
          child: SizedBox(
            height: 52.h,
            child: Row(
              children: [
                _avatarImage(),
                horizontalSpace(12.w),
                _callerNameTime(),
                const Spacer(),
                _endCallButton(),
              ],
            ),
          ),
        ),
        _grayBar()
      ],
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
      ],
    );
  }

  Widget _callerNameTime() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jhon Abraham',
          style: AppTextStyles.poppinsFont18Black100Medium1,
        ),
        verticalSpace(6.h),
        Row(children: [
          SizedBox(
            width: 16.w,
            height: 16.h,
            child: SvgPicture.asset(
              'assets/images/svgs/outgoing_call.svg',
            ),
          ),
          horizontalSpace(4.w),
          Text(
            'Today, 07:30 AM',
            style: AppTextStyles.poppinsFont12Gray50Regular1,
          )
        ])
      ],
    );
  }

  Widget _endCallButton() {
    return Row(
      children: [
        SizedBox(
          width: 24.w,
          height: 24.h,
          child: SvgPicture.asset(
            'assets/images/svgs/calls.svg',
            colorFilter: ColorFilter.mode(
              AppColor.black,
              BlendMode.srcIn,
            ),
          ),
        ),
        horizontalSpace(16.w),
        SizedBox(
          width: 24.w,
          height: 24.h,
          child: SvgPicture.asset(
            'assets/images/svgs/video_call.svg',
          ),
        ),
      ],
    );
  }

  Widget _grayBar() {
    return Padding(
      padding: EdgeInsets.only(
        left: 95.w,
      ),
      child: Container(
        width: double.infinity,
        height: 1.h,
        decoration: BoxDecoration(
          color: AppColor.lighterGray,
        ),
      ),
    );
  }
}
