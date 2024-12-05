import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/call_details.dart';
import 'package:chitchat/src/features/home/presentation/widgets/contacts/add_contact.dart';
import 'package:chitchat/src/features/home/presentation/widgets/contacts/contacts_details.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_bar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactsBody extends StatelessWidget {
  const ContactsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        verticalSpace(60.h),
        GeneralHomeBar(
          title: 'Contacts',
          onTap: () {},
          rightWidget: const AddContact(),
        ),
        verticalSpace(30.h),
        GeneralHomeBody(
          body: ContactsDetails(),
          header: 'My Contact',
        ),
      ],
    );
  }
}
