import 'package:flutter/material.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.onSettings});

  final String title;
  final String content;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: onSettings,
          child: Text("Settings"),
        ),
      ],
    );
  }
}
