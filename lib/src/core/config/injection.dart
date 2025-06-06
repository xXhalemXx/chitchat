import 'package:chitchat/src/core/networking/sources/firebase_source.dart';
import 'package:chitchat/src/core/networking/sources/sources.dart';
import 'package:chitchat/src/features/Authentication/data/repo/repo.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/validators.dart';
import 'package:chitchat/src/features/home/data/repo/repo.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/incoming/incoming_call_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/outgoing/outgoing_call_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/webrtc.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_history_cubit/call_history_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/contacts_cubit/contacts_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/messages_cubit/messages_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/settings_cubit/settings_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIT() {
  // injection for global use
  getIt.registerLazySingleton<HomeRemoteDataSource>(() =>
      HomeRemoteDataSourceFirebase(
          firebaseFirestore: FirebaseFirestore.instance));
  //injection for authentication
  getIt.registerLazySingleton<Validators>(() => Validators());
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepository(remoteDataSource: getIt()));
  getIt.registerLazySingleton<AuthCubit>(() =>
      AuthCubit(validators: getIt<Validators>(), authRepository: getIt()));
  //injection for home
  getIt.registerLazySingleton<DashboardCubit>(() => DashboardCubit());
  getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepository(remoteDataSource: getIt()));
  getIt
      .registerSingleton<MessagesCubit>(MessagesCubit(homeRepository: getIt()));
  getIt.registerSingleton<ChatCubit>(ChatCubit(homeRepository: getIt()));
  getIt.registerLazySingleton<Webrtc>(() => Webrtc());
  getIt.registerSingleton<OutgoingCallCubit>(
      OutgoingCallCubit(homeRepository: getIt(), webrtc: getIt()));
  getIt.registerSingleton<IncomingCallCubit>(
      IncomingCallCubit(homeRepository: getIt(), webrtc: getIt()));

  getIt.registerLazySingleton<CallHistoryCubit>(
      () => CallHistoryCubit(homeRepository: getIt()));
  getIt.registerLazySingleton<ContactsCubit>(() => ContactsCubit());
  getIt.registerLazySingleton<SettingsCubit>(
      () => SettingsCubit(homeRepository: getIt()));
}
