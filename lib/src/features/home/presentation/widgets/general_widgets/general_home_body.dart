import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralHomeBody extends StatelessWidget {
  const GeneralHomeBody({super.key, this.header, required this.body});
  final String? header;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: _boxDecorationFun(),
        child: Column(
          children: [
            verticalSpace(14.h),
            _grayBar(),
            verticalSpace(14.h),
            _optionalHeader(),
            Expanded(
              child: body,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecorationFun() {
    return BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0.r), topRight: Radius.circular(40.0.r)),
      color: AppColor.white,
    );
  }

  Widget _grayBar() {
    return Container(
      width: 30.w,
      height: 3.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: AppColor.lightestGray,
      ),
    );
  }

  Widget _optionalHeader() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 24.0.w),
        child: Column(
          children: [
            header == null
                ? const SizedBox.shrink()
                : Text(
                    header!,
                    style: AppTextStyles.poppinsFont16Black100Medium1,
                  ),
            header == null ? const SizedBox.shrink() : verticalSpace(10.h),
          ],
        ),
      ),
    );
  }
}
