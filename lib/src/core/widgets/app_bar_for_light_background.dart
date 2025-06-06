import 'package:chitchat/src/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarForLightBackground extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarForLightBackground(
      {super.key, this.title, this.implyLeading = false});
  final String? title;
  final bool implyLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: implyLeading,
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      title: title != null
          ? Text(
              title!,
              style: AppTextStyles.poppinsFont18Black100Medium1,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
