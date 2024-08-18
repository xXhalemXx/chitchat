import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/authentication_logic.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/validators.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIT() {
  getIt.registerSingleton<Validators>(Validators());
  getIt.registerSingleton<AuthenticationLogic>(AuthenticationLogic());
  getIt.registerSingleton<AuthCubit>(
      AuthCubit(validators: getIt(), authenticationLogic: getIt()));
}
