import 'src/core/config/config.dart';
import 'package:flutter/material.dart';
import 'chitchat_app.dart';

Future<void> main() async {
  //  Here we are calling the Dependency Injection
  await DependencyInjection.init();
  //  This is the main app
  //try fake push
  runApp(const RootApp());
}
