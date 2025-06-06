import 'dart:developer';
import 'dart:io';

import 'package:chitchat/src/core/routes/router.dart';
import 'package:chitchat/src/core/widgets/error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class NetworkExceptions {
  // task exception object and return NetworkExceptions message
  static String getFirebaseExceptionMessage(dynamic error) {
    if (error is SocketException) {
      return 'No internet connection. Please check your network settings.';
    }
    if (error is FirebaseAuthException) {
      log('error code: ${error.code}');
      switch (error.code) {
        case 'email-already-in-use':
          return 'This email is already registered. Try logging in.';
        case 'invalid-email':
          return 'Please enter a valid email address.';
        case 'invalid-credential':
          return 'Please check your email and password.';
        case 'weak-password':
          return 'Password is too weak. Use at least 6 characters.';
        case 'user-disabled':
          return 'This account has been disabled. Contact support.';
        case 'user-not-found':
          return 'No account found with this email.';
        case 'wrong-password':
          return 'Incorrect password. Please try again.';
        case 'network-request-failed':
          return 'Network error. Check your internet connection.';
        case 'too-many-requests':
          return 'Too many attempts. Try again later.';
        case 'account-exists-with-different-credential':
          return 'Account already exists with different login method.';
        default:
          return 'Authentication failed. Please try again.';
      }
    }
    if (error is FirebaseException) {
      log('error code: ${error.code}');
      switch (error.code) {
        case 'permission-denied':
          return 'You don\'t have permission to access this resource.';
        case 'not-found':
          return 'Requested data could not be found.';
        case 'unavailable':
          return 'Service is unavailable. Try again later.';
        case 'storage/object-not-found':
          return 'File not found in storage.';
        case 'storage/unauthorized':
          return 'You\'re not authorized to perform this storage operation.';
        case 'storage/canceled':
          return 'Storage operation was canceled.';
        case 'storage/unknown':
          return 'Unknown storage error occurred.';
        case 'deadline-exceeded':
          return 'Operation timed out. Please try again.';
        default:
          return 'Firebase operation failed: ${error.message}';
      }
    }
    if (error is PlatformException) {
      return 'A device platform error occurred. Restart the app.';
    }
    if (error.toString().contains("is not a subtype of")) {
      return 'Data format mismatch. Contact support.';
    }
    return 'An unexpected error occurred. Please try again.';
  }

  static showErrorDialog(dynamic error) {
    showDialog(
        context: AppRouter.navigatorKey.currentContext!,
        builder: (_) {
          return ErrorDialog(errorMessage: getFirebaseExceptionMessage(error));
        });
  }
}
