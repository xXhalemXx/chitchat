import 'package:chitchat/src/core/cached_data/cached_data.dart';
import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/models/user_data.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/core/routes/routes.dart';
import 'package:chitchat/src/core/widgets/success_dialog.dart';
import 'package:chitchat/src/features/Authentication/data/repo/repo.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.validators, required this.authRepository})
      : super(AuthInitial());
  Validators validators;
  final AuthRepository authRepository;

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
    UserModel? user = await authRepository.signInWithGoogle();
    if (context.mounted && user != null) {
      _saveUserModelAndNavigate(user: user, context: context);
    }
    emit(AuthLoaded());
  }

  Future<void> loginWithEmailAndPassword(
      {required BuildContext context}) async {
    if (getIt<AuthCubit>().loginFormKey.currentState!.validate()) {
      emit(AuthLoading());
      UserModel user = await authRepository.loginWithEmailAndPassword(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      );
      if (context.mounted) {
        _saveUserModelAndNavigate(user: user, context: context);
      }
      emit(AuthLoaded());
    }
  }

  _saveUserModelAndNavigate(
      {required UserModel user, required BuildContext context}) {
    // save user details in cache
    getIt<CacheData>().setString(key: 'UID', value: user.uId);
    // save user details in global class
    UserData.currentUser = user;
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.dashboard,
      (Route<dynamic> route) => false,
    );
    authRepository.updateUserLastSeen(uId: user.uId);
  }

  Future<void> registerUsingEmailAndPassword({
    required BuildContext context,
  }) async {
    if (getIt<AuthCubit>().signUpFormKey.currentState!.validate()) {
      emit(AuthLoading());

      await authRepository.registerWithEmailAndPassword(
        email: signUpEmailController.text,
        password: signUpPasswordController.text,
        name: signUpNameController.text,
      );

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) =>
              const SuccessDialog(message: 'Your account created successfully'),
        );
      }

      emit(AuthLoaded());
    }
  }
}
