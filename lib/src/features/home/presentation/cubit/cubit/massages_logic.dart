import 'dart:async';
import 'dart:io';

import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/models/message_model.dart';
import 'package:chitchat/src/core/models/user_model.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MassagesLogic {
  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> allUsers = [];
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await usersRef.get();
    List<QueryDocumentSnapshot> allDocs = querySnapshot.docs;
    for (var doc in allDocs) {
      if (doc.id != getIt<HomeCubit>().currentUser.uId) {
        allUsers.add(UserModel.fromJason(doc.data() as Map<String, dynamic>));
      }
    }
    return allUsers;
  }

  Future<List<UserModel>> getUsersHaveChatWith() async {
    try {
      List<UserModel> allUsers = [];
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      List<QueryDocumentSnapshot> allDocs = querySnapshot.docs;
      for (var doc in allDocs) {
        Map<String, dynamic> docMap = doc.data() as Map<String, dynamic>;
        if (docMap['uId'] != getIt<HomeCubit>().currentUser.uId) {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(doc.id)
              .collection('chats')
              .get();
          for (var element in querySnapshot.docs) {
            if (element.id == getIt<HomeCubit>().currentUser.uId) {
              allUsers.add(UserModel.fromJason(docMap));
              break;
            }
          }
        }
      }
      return allUsers;
    } on SocketException catch (_) {
      return [];
    } on FirebaseAuthException catch (e) {
      return [];
    } catch (e) {
      return [];
    }
  }

  void sendMessage({
    required UserModel receiver,
  }) async {
    if (getIt<HomeCubit>().messageController.value.text == '') {
      return;
    }
    try {
      MessageModel message = MessageModel(
          sender: getIt<HomeCubit>().currentUser.uId,
          text: getIt<HomeCubit>().messageController.value.text,
          dateTime: DateTime.now().toString(),
          receiver: receiver.uId);

      // save massage in sender document
      FirebaseFirestore.instance
          .collection('users')
          .doc(getIt<HomeCubit>().currentUser.uId)
          .collection('chats')
          .doc(receiver.uId)
          .collection('messages')
          .add(message.toMap());
      // save massage in receiver document

      FirebaseFirestore.instance
          .collection('users')
          .doc(receiver.uId)
          .collection('chats')
          .doc(getIt<HomeCubit>().currentUser.uId)
          .collection('messages')
          .add(message.toMap());
      getIt<HomeCubit>().messageController.clear();
// just a value added to document to be active
      FirebaseFirestore.instance
          .collection('users')
          .doc(getIt<HomeCubit>().currentUser.uId)
          .collection('chats')
          .doc(receiver.uId)
          .set({'exists': ''});
// just a value added to document to be active

      FirebaseFirestore.instance
          .collection('users')
          .doc(receiver.uId)
          .collection('chats')
          .doc(getIt<HomeCubit>().currentUser.uId)
          .set({'exists': ''});
    } on SocketException catch (_) {
      // defaultErrorToast(message: 'No internet connection');
    } on FirebaseAuthException catch (e) {
      // defaultErrorToast(message: e.message!);
    } catch (e) {
      // defaultErrorToast(message: e.toString());
    }
  }

  getAllMessages({
    required UserModel receiver,
    required Function(List<MessageModel>) onMessagesFetched,
  }) async {
    try {
      List<MessageModel> allMessages = [];
      FirebaseFirestore.instance
          .collection('users')
          .doc(getIt<HomeCubit>().currentUser.uId)
          .collection('chats')
          .doc(receiver.uId)
          .collection('messages')
          .orderBy('dateTime')
          .snapshots()
          .listen((event) {
        allMessages = [];
        for (var element in event.docs) {
          allMessages.add(MessageModel.fromJason(element.data()));
        }
        //scroll to the bottom of the chat list when new messages arrive
        WidgetsBinding.instance.addPostFrameCallback((_) {
          getIt<HomeCubit>().scrollController.jumpTo(
              getIt<HomeCubit>().scrollController.position.maxScrollExtent);
        });
        onMessagesFetched(allMessages);
      });
    } on SocketException catch (_) {
    } on FirebaseAuthException catch (e) {
    } catch (e) {}
  }
}
