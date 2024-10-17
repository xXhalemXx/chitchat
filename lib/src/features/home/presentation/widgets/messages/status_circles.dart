import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusCircles extends StatelessWidget {
  const StatusCircles({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 21.0.w),
      child: SizedBox(
        height: 82.h,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 20,
          itemBuilder: (context, index) {
            return _circle();
          },
        ),
      ),
    );
  }

  Widget _circle() {
    return Container(
      margin: EdgeInsets.only(right: 12.0.w),
      width: 58.w,
      height: 82.h,
      child: Column(
        children: [
          Container(
            width: 58.w,
            height: 58.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: AppColor.white.withOpacity(0.6), width: 1.0.w)),
            child: Center(
              child: Container(
                width: 52.w,
                height: 52.h,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: CircleAvatar(
                  child: Image.asset('assets/images/person_1.png'),
                ),
              ),
            ),
          ),
          verticalSpace(10.h),
          Expanded(
            child: Text(
              'Samy',
              style: AppTextStyles.poppinsFont14White100Regular1,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
