import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_bar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/settings/settings_list.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        verticalSpace(60),
        GeneralAppBar(
          title: 'Settings',
          onTap: () {},
        ),
        verticalSpace(30),
        GeneralHomeBody(
          body: SettingsList(),
        ),
      ],
    );
  }
}
