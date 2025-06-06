import 'dart:developer';

import 'package:chitchat/src/core/config/config.dart';

import 'package:chitchat/src/core/networking/models/user_call_model.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/core/routes/names.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:chitchat/src/features/Authentication/presentation/pages/login_screen.dart';
import 'package:chitchat/src/features/Authentication/presentation/pages/onboarding_screen.dart';
import 'package:chitchat/src/features/Authentication/presentation/pages/sign_up_screen.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/incoming/incoming_call_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/outgoing/outgoing_call_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/settings_cubit/settings_cubit.dart';
import 'package:chitchat/src/features/home/presentation/pages/call_pages/outgoing_call_page.dart';
import 'package:chitchat/src/features/home/presentation/pages/chat_page.dart';
import 'package:chitchat/src/features/home/presentation/pages/dashboard_screen.dart';
import 'package:chitchat/src/features/home/presentation/pages/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/src/core/error/error.dart';

class AppRouter {
  static const initial = RoutesName.initial;
  static final navigatorKey = GlobalKey<NavigatorState>();
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
              BlocProvider.value(
                  value: getIt<IncomingCallCubit>()..listenForIncomingCall()),
              BlocProvider.value(value: getIt<DashboardCubit>()),
              BlocProvider.value(value: getIt<OutgoingCallCubit>()),
            ],
            child: DashboardScreen(),
          ),
        );
      case RoutesName.chat:
        final UserModel receiver = settings!.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<ChatCubit>()..getAllMassages(receiver: receiver),
              ),
              BlocProvider.value(value: getIt<IncomingCallCubit>()),
            ],
            child: ChatPage(
              receiver: receiver,
            ),
          ),
        );
      case RoutesName.outgoingCallPage:
        final UserCallModel receiver = settings!.arguments as UserCallModel;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<OutgoingCallCubit>()),
            ],
            child: OutgoingCallPage(receiver: receiver),
          ),
        );
      case RoutesName.userInfo:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<SettingsCubit>(),
            child: UserInfo(),
          ),
        );

      default:
        // If there is no such named route in the switch statement
        throw const RouteException('Route not found!');
    }
  }

  /// this function to check if user logged in before
  /// so we can open home page directly
  static Future<String> getInitialRoute() async {
    try {
      // if user not logged in before
      if (await getIt<AuthCubit>().checkIfUserDataSaved()) {
        log('message : user logged in before');
        return RoutesName.dashboard;
      } else {
        log('message : user not logged in before');
        return RoutesName.onboarding;
      }
    } catch (e) {
      log('message : user token is not valid With error : $e');
      return RoutesName.onboarding; // Default to login if there's an error
    }
  }
}
