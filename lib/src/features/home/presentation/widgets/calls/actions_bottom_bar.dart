import 'package:chitchat/src/features/home/presentation/widgets/calls/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionsBottomBar extends StatelessWidget {
  const ActionsBottomBar(
      {super.key, required this.buttons, this.horizontalPadding = 70});
  final List<ActionButton> buttons;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
      child: Row(
        mainAxisAlignment: buttons.length == 1
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: buttons,
      ),
    );
  }
}
