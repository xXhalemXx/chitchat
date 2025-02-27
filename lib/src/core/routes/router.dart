import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/core/routes/names.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:chitchat/src/features/Authentication/presentation/pages/login_screen.dart';
import 'package:chitchat/src/features/Authentication/presentation/pages/onboarding_screen.dart';
import 'package:chitchat/src/features/Authentication/presentation/pages/sign_up_screen.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/call_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/messages_cubit/messages_cubit.dart';
import 'package:chitchat/src/features/home/presentation/pages/call_pages/outgoing_call_page.dart';
import 'package:chitchat/src/features/home/presentation/pages/chat_page.dart';
import 'package:chitchat/src/features/home/presentation/pages/dashboard_screen.dart';
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
                  value: getIt<MessagesCubit>()
                    ..loadData()
                    ..autoUpdateChatHeaders()),
              BlocProvider.value(value: getIt<DashboardCubit>()),
              BlocProvider.value(
                  value: getIt<CallCubit>()..listenForIncomingCall()),
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
              BlocProvider.value(value: getIt<CallCubit>()),
            ],
            child: ChatPage(
              receiver: receiver,
            ),
          ),
        );
      case RoutesName.outgoingCallPage:
        final UserModel receiver = settings!.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<CallCubit>()),
            ],
            child: OutgoingCallPage(receiver: receiver),
          ),
        );

      default:
        // If there is no such named route in the switch statement
        throw const RouteException('Route not found!');
    }
  }
}
