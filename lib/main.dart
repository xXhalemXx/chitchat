import 'package:chitchat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/core/config/config.dart';
import 'package:flutter/material.dart';
import 'chitchat_app.dart';

Future<void> main() async {
  //  Here we are calling the Dependency Injection
  setupGetIT();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //  This is the main app
  runApp(const RootApp());
}
