import 'package:chitchat/src/core/constants/assets.dart';
import 'package:flutter/material.dart';

class GeneralBackgroundWrapper extends StatelessWidget {
  const GeneralBackgroundWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.assetsImagesDashboardBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
