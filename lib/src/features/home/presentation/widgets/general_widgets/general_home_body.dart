import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/home/presentation/widgets/meassages/chat_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

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
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ChatHeader();
                },
              ),
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
        color: AppColor.lighterGray,
      ),
    );
  }
}
