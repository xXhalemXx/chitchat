import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/widgets/error_dialog.dart';
import 'package:chitchat/src/core/widgets/success_dialog.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationLogic {
  signInWithGoogle({required BuildContext context}) async {
    // Trigger the authentication flow
    //* final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    //*final GoogleSignInAuthentication? googleAuth =
    //*    await googleUser?.authentication;

    // Create a new credential
    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );

    // Once signed in, return the UserCredential
    // UserCredential userCredential =
    //     await FirebaseAuth.instance.signInWithCredential(credential);
    if (context.mounted) {
      Navigator.pushNamed(context, '/home');
    }
    // return userCredential;
  }

  loginWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      if (getIt<AuthCubit>().loginFormKey.currentState!.validate()) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        if (context.mounted) {
          Navigator.pushNamed(context, '/home');
        }
      }
    } catch (error) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => ErrorDialog(
            errorMessage: error.toString(),
          ),
        );
      }
    }
  }

  registerWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      if (getIt<AuthCubit>().signUpFormKey.currentState!.validate()) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (_) => const SuccessDialog(
                message: 'Your account created successfully'),
          );
        }
      }
    } catch (error) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => ErrorDialog(
            errorMessage: error.toString(),
          ),
        );
      }
    }
  }
}
