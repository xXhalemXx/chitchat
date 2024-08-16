library route_pages;

import 'package:chitchat/src/features/login/presentation/pages/login_screen.dart';
import 'package:chitchat/src/features/login/presentation/pages/onboarding_screen.dart';
import 'package:chitchat/src/features/login/presentation/pages/sign_up_screen.dart';
import 'package:flutter/material.dart';
import '/src/core/error/error.dart';
import 'routes.dart';

class AppRoute {
  static const initial = RoutesName.initial;
  static Route<dynamic> generate(RouteSettings? settings) {
    switch (settings?.name) {
      case RoutesName.initial:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );

      case RoutesName.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case RoutesName.signUp:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

      default:
        // If there is no such named route in the switch statement
        throw const RouteException('Route not found!');
    }
  }
}
