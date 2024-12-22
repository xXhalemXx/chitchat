import 'package:chitchat/src/core/cached_data/cached_data.dart';
import 'package:chitchat/src/core/networking/sources/firebase_source.dart';
import 'package:chitchat/src/core/networking/sources/sources.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/authentication_logic.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/validators.dart';
import 'package:chitchat/src/features/home/data/implements/implements.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIT() {
  //injection for cached data
  getIt.registerLazySingleton<CacheData>(() => CacheData());
  //injection for authentication
  getIt.registerLazySingleton<Validators>(() => Validators());
  getIt.registerLazySingleton<AuthenticationLogic>(() => AuthenticationLogic());
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(
      authenticationLogic: getIt<AuthenticationLogic>(),
      validators: getIt<Validators>()));
  //injection for home
  getIt.registerLazySingleton<HomeRemoteDataSource>(() =>
      HomeRemoteDataSourceFirebase(
          firebaseFirestore: FirebaseFirestore.instance));
  getIt.registerLazySingleton<HomeRepositoryImp>(
      () => HomeRepositoryImp(remoteDataSource: getIt()));
  getIt.registerSingleton<HomeCubit>(HomeCubit(homeRepositoryImp: getIt()));
}
