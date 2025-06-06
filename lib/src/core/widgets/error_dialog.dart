import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:chitchat/src/core/widgets/common_button.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.errorMessage,
  });
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Error',
        style: AppTextStyles.poppinsFont18Red100Bold1,
      ),
      content: Text(
        errorMessage,
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
