import 'dart:developer';

import 'package:chitchat/src/core/constants/strings.dart';
import 'package:chitchat/src/core/networking/models/call_history_model.dart';
import 'package:chitchat/src/core/networking/models/ice_candidate_model.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/features/home/data/models/message_model.dart';
import 'package:chitchat/src/features/home/data/models/user_with_last_message_model.dart';
import 'package:chitchat/src/core/networking/sources/sources.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeRemoteDataSourceFirebase implements HomeRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  HomeRemoteDataSourceFirebase({required this.firebaseFirestore});

//** aut cubit function */
  @override
  Future<UserModel?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    if (googleAuth == null) {
      return null;
    }
    //Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Sign in with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);
    // access fire store to see if user exists or not
    DocumentSnapshot<Map<String, dynamic>> doc = await firebaseFirestore
        .collection(FirebaseStrings.users)
        .doc(FirebaseAuth.instance.currentUser?.uid ?? '')
        .get();
    if (doc.exists) {
      return UserModel(
        email: doc[FirebaseStrings.email],
        phone: doc[FirebaseStrings.phone],
        name: doc[FirebaseStrings.name],
        uId: doc[FirebaseStrings.userID],
        photo: doc[FirebaseStrings.photo],
        bio: doc[FirebaseStrings.bio],
        lastActivity: doc[FirebaseStrings.lastActivity],
        callsHistory: doc[FirebaseStrings.callsHistory],
      );
    } else {
      //convert firebase user to User model
      final UserModel user =
          _covertFirebaseUserToUserModel(FirebaseAuth.instance.currentUser);

      // save user in Firestore
      await _saveUserInFireStore(
        user: user,
      );

      return user;
    }
  }

  @override
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    // access fire store to get user data
    DocumentSnapshot<Map<String, dynamic>> doc = await firebaseFirestore
        .collection(FirebaseStrings.users)
        .doc(credential.user?.uid ?? '')
        .get();

    return UserModel(
      email: email,
      phone: doc[FirebaseStrings.phone],
      name: doc[FirebaseStrings.name],
      uId: doc[FirebaseStrings.userID],
      photo: doc[FirebaseStrings.photo],
      bio: doc[FirebaseStrings.bio],
      lastActivity: doc[FirebaseStrings.lastActivity],
      callsHistory: doc[FirebaseStrings.callsHistory],
    );
  }

  @override
  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    UserModel user = UserModel(
      email: email,
      phone: '',
      name: name,
      uId: userCredential.user!.uid,
      photo: '',
      bio: '',
      callsHistory: [],
      lastActivity: DateTime.now().toString(),
    );
    // save user in Firestore
    await _saveUserInFireStore(
      user: user,
    );

    return user;
  }

//**private methods to save user in firestore */

// to save user data in firestore
  Future<void> _saveUserInFireStore({
    required var user,
  }) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection(FirebaseStrings.users)
        .doc(user.uId)
        .get();
    if (!documentSnapshot.exists) {
      await FirebaseFirestore.instance
          .collection(FirebaseStrings.users)
          .doc(user.uId)
          .set(user.toMap());
    }
  }

// used in signInWithGoogle function
  UserModel _covertFirebaseUserToUserModel(User? user) {
    return UserModel(
      email: user?.email ?? '',
      phone: user?.phoneNumber ?? '',
      name: user?.displayName ?? '',
      uId: user?.uid ?? '',
      photo: '',
      bio: '',
      callsHistory: [],
      lastActivity: DateTime.now().toString(),
    );
  }
//** end of private methods */
//** end of  aut cubit function */

//** home cubit function */
  @override
  Future<List<UserModel>> fetchAllUsers({required String userId}) async {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection(FirebaseStrings.users).get();
    return querySnapshot.docs
        .where((doc) => doc.id != userId)
        .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<UserModel>> fetchUsersHaveChatWith(
      {required String userId}) async {
    QuerySnapshot chatsSnapshot = await firebaseFirestore
        .collection(FirebaseStrings.users)
        .doc(userId)
        .collection(FirebaseStrings.chats)
        .get();

    // Extract user IDs from chats
    List<String> chattedUserIds =
        chatsSnapshot.docs.map((doc) => doc.id).toList();

    if (chattedUserIds.isEmpty) {
      return [];
    }

    // Fetch user details in a single query using 'whereIn'

    List<UserModel> users = [];
    const int batchSize = 10;
    for (int i = 0; i < chattedUserIds.length; i += batchSize) {
      // to get 10 user at batch firebase allow 10 (read) user at batch
      List<String> batch = chattedUserIds.skip(i).take(batchSize).toList();
      QuerySnapshot usersSnapshot = await firebaseFirestore
          .collection(FirebaseStrings.users)
          .where(FirebaseStrings.userID, whereIn: batch)
          .get();

      users.addAll(
        usersSnapshot.docs
            .map(
                (doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList(),
      );
    }

    return users;
  }

  @override
  Stream<List<UserWithLastMessage>> fetchUsersWithLastMessage(
      {required String userId}) {
    return firebaseFirestore
        .collection(FirebaseStrings.users)
        .snapshots()
        .asyncMap((usersSnapshot) async {
      List<UserWithLastMessage> usersWithLastMessage = [];
      for (var userDoc in usersSnapshot.docs) {
        if (userDoc.id != userId) {
          UserModel user = UserModel.fromJson(userDoc.data());

          CollectionReference messagesRef = firebaseFirestore
              .collection(FirebaseStrings.users)
              .doc(userId)
              .collection(FirebaseStrings.chats)
              .doc(userDoc.id)
              .collection(FirebaseStrings.messages);

          // Fetch the last message
          QuerySnapshot chatSnapshot = await messagesRef
              .orderBy(FirebaseStrings.dateTime, descending: true)
              .limit(1)
              .get();

          // Count unread messages where receiver is the current user and isSeen is false
          QuerySnapshot unreadSnapshot = await messagesRef
              .where(FirebaseStrings.receiver, isEqualTo: userId)
              .where(FirebaseStrings.isSeen, isEqualTo: false)
              .get();

          int unreadCount = unreadSnapshot.docs.length;
          if (chatSnapshot.docs.isNotEmpty) {
            usersWithLastMessage.add(
              UserWithLastMessage(
                lastMessageTime: DateTime.parse(
                  chatSnapshot.docs.first[FirebaseStrings.dateTime],
                ),
                user: user,
                lastMessage: chatSnapshot.docs.first[FirebaseStrings.text],
                unreadCount: unreadCount,
              ),
            );
          }
        }
      }

      return usersWithLastMessage;
    });
  }

  @override
  Stream<List<MessageModel>> fetchMessages({
    required UserModel receiver,
    required String userId,
  }) {
    return firebaseFirestore
        .collection(FirebaseStrings.users)
        .doc(userId)
        .collection(FirebaseStrings.chats)
        .doc(receiver.uId)
        .collection(FirebaseStrings.messages)
        .orderBy(FirebaseStrings.dateTime)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MessageModel.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Future<void> sendMessage({
    required UserModel receiver,
    required String messageText,
    required String userId,
  }) async {
    if (messageText == '') {
      return;
    }
    MessageModel message = MessageModel(
        sender: userId,
        text: messageText,
        dateTime: DateTime.now().toString(),
        receiver: receiver.uId);

    // save massage in sender document
    FirebaseFirestore.instance
        .collection(FirebaseStrings.users)
        .doc(userId)
        .collection(FirebaseStrings.chats)
        .doc(receiver.uId)
        .collection(FirebaseStrings.messages)
        .add(message.toMap());
    // save massage in receiver document

    FirebaseFirestore.instance
        .collection(FirebaseStrings.users)
        .doc(receiver.uId)
        .collection(FirebaseStrings.chats)
        .doc(userId)
        .collection(FirebaseStrings.messages)
        .add(message.toMap());
// just a value added to document to be active
    FirebaseFirestore.instance
        .collection(FirebaseStrings.users)
        .doc(userId)
        .collection(FirebaseStrings.chats)
        .doc(receiver.uId)
        .set({FirebaseStrings.exists: ''});
// just a value added to document to be active

    FirebaseFirestore.instance
        .collection(FirebaseStrings.users)
        .doc(receiver.uId)
        .collection(FirebaseStrings.chats)
        .doc(userId)
        .set({FirebaseStrings.exists: ''});
  }

  @override
  Future<void> markAllMessagesSeen(
      {required String userId, required String receiverUId}) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Reference to the messages collection
    final CollectionReference messagesRef = firebaseFirestore
        .collection(FirebaseStrings.users)
        .doc(userId)
        .collection(FirebaseStrings.chats)
        .doc(receiverUId)
        .collection(FirebaseStrings.messages);

    // Query to fetch all unread messages
    Query query = messagesRef.where(FirebaseStrings.isSeen, isEqualTo: false);

    // Run the query and get the snapshot
    QuerySnapshot querySnapshot = await query.get();

    // Check if there are any unread messages
    if (querySnapshot.docs.isEmpty) {
      return;
    }

    // Firestore batch limit is 500 operations per batch
    const int batchSize = 500;
    int totalDocs = querySnapshot.docs.length;
    int batches = (totalDocs / batchSize).ceil();

    for (int i = 0; i < batches; i++) {
      // Determine the start and end index for this batch
      int start = i * batchSize;
      int end = start + batchSize;
      if (end > totalDocs) end = totalDocs;

      // Extract the current batch of documents
      List<DocumentSnapshot> batchDocs = querySnapshot.docs.sublist(start, end);

      // Create a new batch
      WriteBatch writeBatch = firebaseFirestore.batch();

      // Add update operations to the batch
      for (var doc in batchDocs) {
        writeBatch.update(doc.reference, {FirebaseStrings.isSeen: true});
      }

      // Commit the batch
      await writeBatch.commit();
    }
  }

  @override
  Future<void> updateUserLastSeen({required String uId}) async {
    await firebaseFirestore
        .collection(FirebaseStrings.users)
        .doc(uId)
        .update({FirebaseStrings.lastActivity: DateTime.now().toString()});
  }
  //**end of home cubit function */

  //** call cubit function */
  final CollectionReference _signalingRef =
      FirebaseFirestore.instance.collection(FirebaseStrings.signaling);
  @override
  Future<String> createCall(
      String callerId, String receiverId, String calleeName) async {
    DocumentReference callDoc = _signalingRef.doc();

    await callDoc.set({
      FirebaseStrings.callerId: callerId,
      FirebaseStrings.receiverId: receiverId,
      FirebaseStrings.callStatus: 0,
      FirebaseStrings.offer: null,
      FirebaseStrings.answer: null,
      FirebaseStrings.iceCandidates: [],
      FirebaseStrings.callId: callDoc.id,
    });
    return callDoc.id;
  }

  @override
  Future<void> sendOffer(String callId, Map<String, dynamic> offer) async {
    DocumentReference callDoc = _signalingRef.doc(callId);
    await callDoc.update({FirebaseStrings.offer: offer});
  }

  @override
  Future<void> sendAnswer(String callId, Map<String, dynamic> answer) async {
    DocumentReference callDoc = _signalingRef.doc(callId);
    await callDoc.update({FirebaseStrings.answer: answer});
  }

  /// call status can be 5 values
  /// 0: call is initiated
  /// 1: call is answered
  /// 2: call is rejected
  /// 3: user in not answering
  /// 4: user in another call
  @override
  Future<void> updateCallStatus(String callId, int callStatus) async {
    DocumentReference callDoc = _signalingRef.doc(callId);
    await callDoc.update({FirebaseStrings.callStatus: callStatus});
  }

  @override
  Future<void> addIceCandidate(
      String callId, IceCandidateModel candidate) async {
    DocumentReference callDoc = _signalingRef.doc(callId);
    await callDoc.update({
      FirebaseStrings.iceCandidates:
          FieldValue.arrayUnion([candidate.toJson()]),
    });
  }

  @override
  Future<Map<String, dynamic>?> getCallData(String callId) async {
    DocumentReference callDoc = _signalingRef.doc(callId);
    DocumentSnapshot callSnapshot = await callDoc.get();
    return callSnapshot.exists
        ? callSnapshot.data() as Map<String, dynamic>?
        : null;
  }

  @override
  Stream<Map<String, dynamic>?> onCallDataChanged(String callId) {
    DocumentReference callDoc = _signalingRef.doc(callId);
    return callDoc
        .snapshots()
        .map((doc) => doc.exists ? doc.data() as Map<String, dynamic>? : null);
  }

  @override
  Stream<Map<String, dynamic>> onNewCallCreated() {
    return _signalingRef
        .snapshots()
        .map((snapshot) {
          for (var doc in snapshot.docChanges) {
            if (doc.type == DocumentChangeType.added) {
              return doc.doc.data();
            }
          }
          return null;
        })
        .where((data) => data != null)
        .cast<Map<String, dynamic>>();
  }

  /// this function is called when the call is ended
  /// it updates the call history of both users
  /// and deletes the call signaling document
  @override
  Future<void> onCallEnd(
      String callId, String callerId, CallHistoryModel callData) async {
    // update the call history of the caller
    await FirebaseFirestore.instance
        .collection(FirebaseStrings.users)
        .doc(callerId)
        .update({
      FirebaseStrings.callsHistory: FieldValue.arrayUnion([callData.toJson()])
    });
    String receiverId = callData.idOfOtherUser;
    callData.idOfOtherUser = callerId;
    // update the call history of the receiver
    await FirebaseFirestore.instance
        .collection(FirebaseStrings.users)
        .doc(receiverId)
        .update({
      FirebaseStrings.callsHistory: FieldValue.arrayUnion([callData.toJson()])
    });
    await _signalingRef.doc(callId).delete();
  }
  //**end of call cubit function */
}
