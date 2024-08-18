import 'package:chitchat/src/features/Authentication/presentation/cubit/authentication_logic.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.validators, required this.authenticationLogic})
      : super(AuthInitial());
  Validators validators;
  AuthenticationLogic authenticationLogic;
  //** validators
  String? nameValidator(String? value) {
    return validators.nameValidator(value);
  }

  String? emailValidator(String? value) {
    return validators.emailValidator(value);
  }

  String? passwordValidator(String? value) {
    return validators.passwordValidator(value);
  }

  //** authentication logic

  Future<void> signInWithGoogle() async {
    //emit(AuthLoading());
    await authenticationLogic.signInWithGoogle();
    //emit(AuthSuccess());
  }

  Future<void> signInWithFacebook() async {
    //emit(AuthLoading());
    await authenticationLogic.signInWithFacebook();
    //emit(AuthSuccess());
  }
}
