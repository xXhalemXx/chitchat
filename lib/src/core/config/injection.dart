import 'package:chitchat/src/core/cached_data/cached_data.dart';
import 'package:chitchat/src/core/global/current_user_data.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/authentication_logic.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/validators.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/massages_logic.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIT() {
  //injection for cached data
  getIt.registerLazySingleton<CacheData>(() => CacheData());
  getIt.registerLazySingleton<CurrentUserData>(() => CurrentUserData());
  //injection for authentication
  getIt.registerLazySingleton<Validators>(() => Validators());
  getIt.registerLazySingleton<AuthenticationLogic>(() => AuthenticationLogic());
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(
      authenticationLogic: getIt<AuthenticationLogic>(),
      validators: getIt<Validators>()));
  //injection for home
  getIt.registerLazySingleton<MassagesLogic>(() => MassagesLogic());
  getIt.registerLazySingleton<HomeCubit>(
      () => HomeCubit(massagesLogic: getIt<MassagesLogic>()));
}
