import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:chitchat/src/core/widgets/common_button.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({
    super.key,
    required this.message,
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Success',
        style: AppTextStyles.poppinsFont18Green100Medium1,
      ),
      content: Text(
        message,
        style: AppTextStyles.poppinsFont16Black100Medium1,
        textAlign: TextAlign.center,
      ),
      actions: [
        AppTextButton(
            buttonText: 'ok',
            textStyle: AppTextStyles.poppinsFont16White100Medium1,
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}
