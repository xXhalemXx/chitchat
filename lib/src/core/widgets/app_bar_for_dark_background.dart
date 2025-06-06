import 'package:chitchat/src/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarForDarkBackground extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarForDarkBackground(
      {super.key, this.title, this.implyLeading = false});
  final String? title;
  final bool implyLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: implyLeading,
      leading: implyLeading
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      title: title != null
          ? Text(
              title!,
              style: AppTextStyles.poppinsFont20White100Medium1,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
