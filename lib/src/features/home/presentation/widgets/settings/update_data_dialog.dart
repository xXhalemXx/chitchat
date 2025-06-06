import 'package:flutter/material.dart';

class UpdateDataDialog extends StatelessWidget {
  const UpdateDataDialog(
      {super.key,
      required this.title,
      required this.hintText,
      required this.onSave,
      required this.textEditingController});
  final String title;
  final String hintText;
  final VoidCallback onSave;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: textEditingController,
        maxLength: 150, // Limit bio length
        decoration: InputDecoration(hintText: hintText),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Close dialog
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: onSave,
          child: Text("Save"),
        ),
      ],
    );
  }
}
