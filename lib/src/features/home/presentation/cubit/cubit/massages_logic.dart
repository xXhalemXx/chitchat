import 'dart:io';

import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/global/current_user_data.dart';
import 'package:chitchat/src/core/models/message_model.dart';
import 'package:chitchat/src/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MassagesLogic {
  getAllUsers() async {
    List<UserModel> allUsers = [];
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await usersRef.get();
    List<QueryDocumentSnapshot> allDocs = querySnapshot.docs;
    for (var doc in allDocs) {
      if (doc.id != getIt<CurrentUserData>().currentUser.uId) {
        allUsers.add(UserModel.fromJason(doc.data() as Map<String, dynamic>));
      }
    }
  }

  getUsersHaveChatWith() async {
    try {
      List<UserModel> allUsers = [];
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      List<QueryDocumentSnapshot> allDocs = querySnapshot.docs;
      for (var doc in allDocs) {
        Map<String, dynamic> docMap = doc.data() as Map<String, dynamic>;
        if (docMap['uId'] != getIt<CurrentUserData>().currentUser.uId) {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(doc.id)
              .collection('chats')
              .get();
          for (var element in querySnapshot.docs) {
            if (element.id == getIt<CurrentUserData>().currentUser.uId) {
              allUsers.add(UserModel.fromJason(docMap));
              break;
            }
          }
        }
      }
    } on SocketException catch (_) {
    } on FirebaseAuthException catch (e) {
    } catch (e) {}
  }

  void sendMessage({
    required UserModel sender,
    required UserModel receiver,
    required TextEditingController messageController,
  }) async {
    if (messageController.value.text == '') {
      return;
    }
    try {
      MessageModel message = MessageModel(
          sender: sender.uId,
          text: messageController.value.text,
          dateTime: DateTime.now().toString(),
          receiver: receiver.uId);

      // save massage in sender document
      FirebaseFirestore.instance
          .collection('users')
          .doc(sender.uId)
          .collection('chats')
          .doc(receiver.uId)
          .collection('messages')
          .add(message.toMap());
      // save massage in receiver document

      FirebaseFirestore.instance
          .collection('users')
          .doc(receiver.uId)
          .collection('chats')
          .doc(sender.uId)
          .collection('messages')
          .add(message.toMap());
      messageController.clear();
// just a value added to document to be active
      FirebaseFirestore.instance
          .collection('users')
          .doc(sender.uId)
          .collection('chats')
          .doc(receiver.uId)
          .set({'exists': ''});
// just a value added to document to be active

      FirebaseFirestore.instance
          .collection('users')
          .doc(receiver.uId)
          .collection('chats')
          .doc(sender.uId)
          .set({'exists': ''});
    } on SocketException catch (_) {
      // defaultErrorToast(message: 'No internet connection');
    } on FirebaseAuthException catch (e) {
      // defaultErrorToast(message: e.message!);
    } catch (e) {
      // defaultErrorToast(message: e.toString());
    }
  }
}
