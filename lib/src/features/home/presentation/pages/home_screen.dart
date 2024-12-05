import 'package:chitchat/src/features/home/presentation/widgets/calls/calls_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/contacts/contacts_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/home_bottom_bar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/messages/messages_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/settings/settings_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _homeBodes = const [
    MessagesBody(),
    CallsBody(),
    ContactsBody(),
    SettingsBody(),
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: _boxDecorationFun(),
        child: _homeBodes[_currentIndex],
      ),
      bottomNavigationBar: HomeBottomBar(
        currentIndex: _currentIndex,
        onTabTapped: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  BoxDecoration _boxDecorationFun() {
    return const BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/images/home_background.png"),
          fit: BoxFit.cover),
    );
  }
}
