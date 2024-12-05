import 'package:chitchat/src/features/Authentication/presentation/cubit/authentication_logic.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.validators, required this.authenticationLogic})
      : super(AuthInitial());
  Validators validators;
  AuthenticationLogic authenticationLogic;

  //** text editing controllers for sign up */
  final TextEditingController signUpNameController = TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();
  final TextEditingController signUpConfirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  //** text editing controllers for login */
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  //** validators */
  String? nameValidator(String? value) {
    return validators.nameValidator(value);
  }

  String? emailValidator(String? value) {
    return validators.emailValidator(value);
  }

  String? passwordValidator(String? value) {
    return validators.passwordValidator(value);
  }

  String? conformPasswordValidator(String? firstPass, String? secondPass) {
    return validators.conformPasswordValidator(firstPass, secondPass);
  }

  //** authentication logic */
  Future<void> signInWithGoogle({required BuildContext context}) async {
    emit(AuthLoading());
    await authenticationLogic.signInWithGoogle(context: context);
    emit(AuthLoaded());
  }

  Future<void> loginWithEmailAndPassword(
      {required BuildContext context}) async {
    emit(AuthLoading());

    await authenticationLogic.loginWithEmailAndPassword(
      email: loginEmailController.text,
      password: loginPasswordController.text,
      context: context,
    );
    emit(AuthLoaded());
  }

  Future<void> registerUsingEmailAndPassword({
    required BuildContext context,
  }) async {
    emit(AuthLoading());

    await authenticationLogic.registerWithEmailAndPassword(
      email: signUpEmailController.text,
      password: signUpPasswordController.text,
      name: signUpNameController.text,
      context: context,
    );

    emit(AuthLoaded());
  }
}
