import 'package:chitchat/src/core/cached_data/cached_data.dart';
import 'package:chitchat/src/core/networking/sources/firebase_source.dart';
import 'package:chitchat/src/core/networking/sources/sources.dart';
import 'package:chitchat/src/features/Authentication/data/repo/repo.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/validators.dart';
import 'package:chitchat/src/features/home/data/repo/repo.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIT() {
  //injection for cached data
  getIt.registerLazySingleton<CacheData>(() => CacheData());
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
  getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepository(remoteDataSource: getIt()));
  getIt.registerSingleton<HomeCubit>(HomeCubit(homeRepository: getIt()));
}
