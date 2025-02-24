library route_pages;

import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/core/routes/names.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:chitchat/src/features/Authentication/presentation/pages/login_screen.dart';
import 'package:chitchat/src/features/Authentication/presentation/pages/onboarding_screen.dart';
import 'package:chitchat/src/features/Authentication/presentation/pages/sign_up_screen.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:chitchat/src/features/home/presentation/pages/chat_page.dart';
import 'package:chitchat/src/features/home/presentation/pages/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/src/core/error/error.dart';

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
          builder: (_) => BlocProvider.value(
            value: getIt<AuthCubit>(),
            child: const SignUpScreen(),
          ),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<AuthCubit>(),
            child: const LoginScreen(),
          ),
        );
      case RoutesName.dashboard:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<HomeCubit>()..loadData()),
              BlocProvider.value(value: getIt<DashboardCubit>()),
            ],
            child: DashboardScreen(),
          ),
        );
      case RoutesName.chat:
        final UserModel receiver = settings!.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<HomeCubit>()..getAllMassages(receiver: receiver),
            child: ChatPage(
              receiver: receiver,
            ),
          ),
        );

      default:
        // If there is no such named route in the switch statement
        throw const RouteException('Route not found!');
    }
  }
}
