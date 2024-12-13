import 'package:chitchat/src/core/cached_data/cached_data.dart';
import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/models/user_model.dart';
import 'package:chitchat/src/core/widgets/error_dialog.dart';
import 'package:chitchat/src/core/widgets/success_dialog.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationLogic {
  signInWithGoogle({required BuildContext context}) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    //Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Sign in with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);
    //convert firebase user to User model
    final UserModel user =
        _covertFirebaseUserToUserModel(FirebaseAuth.instance.currentUser);

    // save user in Firestore
    await _saveUserInFireStore(
      user: user,
    );
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }

    // save user details in cache
    getIt<CacheData>().setString(key: 'UID', value: user.uId);
    // save user details in global class
    getIt<HomeCubit>().currentUser = user;
    // return userCredential;
  }

  UserModel _covertFirebaseUserToUserModel(User? user) {
    return UserModel(
      email: user?.email ?? '',
      phone: user?.phoneNumber ?? '',
      name: user?.displayName ?? '',
      uId: user?.uid ?? '',
      photo: '',
      bio: '',
    );
  }

  loginWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      if (getIt<AuthCubit>().loginFormKey.currentState!.validate()) {
        UserCredential credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
        // save user details in cache
        getIt<CacheData>()
            .setString(key: 'UID', value: credential.user?.uid ?? '');
        // save user details in global class
        getIt<HomeCubit>().currentUser = UserModel(
          email: credential.user?.email ?? '',
          phone: credential.user?.phoneNumber ?? '',
          name: credential.user?.displayName ?? '',
          uId: credential.user?.uid ?? '',
          photo: credential.user?.photoURL ?? '',
          bio: '',
        );
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
      required String name,
      required BuildContext context}) async {
    try {
      if (getIt<AuthCubit>().signUpFormKey.currentState!.validate()) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        // save user in Firestore
        await _saveUserInFireStore(
          user: UserModel(
            email: email,
            phone: '',
            name: name,
            uId: userCredential.user!.uid,
            photo: '',
            bio: '',
          ),
        );
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

  Future<void> _saveUserInFireStore({
    required var user,
  }) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uId)
        .get();
    if (!documentSnapshot.exists) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uId)
          .set(user.toMap());
    }
  }
}
