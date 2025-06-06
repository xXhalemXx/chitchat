import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/home/presentation/widgets/contacts/add_contact.dart';
import 'package:chitchat/src/features/home/presentation/widgets/contacts/contacts_details.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_bar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_body.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        verticalSpace(60),
        GeneralAppBar(
          title: 'Contacts',
          onTap: () {},
          rightWidget: const AddContact(),
        ),
        verticalSpace(30),
        GeneralHomeBody(
          body: ContactsDetails(),
          header: 'My Contact',
        ),
      ],
    );
  }
}
