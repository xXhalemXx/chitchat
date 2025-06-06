import 'package:chitchat/firebase_options.dart';
import 'package:chitchat/src/core/routes/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'src/core/config/config.dart';
import 'package:flutter/material.dart';
import 'chitchat_app.dart';

Future<void> main() async {
  // Ensure Flutter application is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // initialize supabase
  await Supabase.initialize(
    url: 'https://wyuqbwtoqfjicpwfytxi.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind5dXFid3RvcWZqaWNwd2Z5dHhpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDkxNjU1OTEsImV4cCI6MjA2NDc0MTU5MX0.3FrbdZ3yJ4o_kBhybibvnr0DMvwl-bDLTCWm53YJkqE',
  );

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'Chitchat',
  );

  // Call dependency injection setup
  setupGetIT();

  // get initial route
  String initialRoute = await AppRouter.getInitialRoute();

  //  This is the main app
  runApp(RootApp(
    initialRoute: initialRoute,
  ));
}
