import 'package:chitchat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/core/config/config.dart';
import 'package:flutter/material.dart';
import 'chitchat_app.dart';

Future<void> main() async {
  // Ensure Flutter application is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'Chitchat',
  );

  // Call dependency injection setup
  setupGetIT();
  //  This is the main app
  runApp(const RootApp());
}
