import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/calls_details_page/call_details.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/calls_details_page/new_call.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_bar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_body.dart';
import 'package:flutter/material.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        verticalSpace(60),
        GeneralAppBar(
          title: 'Calls',
          onTap: () {},
          rightWidget: const NewCall(),
        ),
        verticalSpace(30),
        const GeneralHomeBody(
          body: CallDetails(),
          header: 'Recent',
        ),
      ],
    );
  }
}
