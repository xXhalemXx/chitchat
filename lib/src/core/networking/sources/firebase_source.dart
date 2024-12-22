import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/features/home/data/models/message_model.dart';
import 'package:chitchat/src/features/home/data/models/user_with_last_message_model.dart';
import 'package:chitchat/src/core/networking/sources/sources.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeRemoteDataSourceFirebase implements HomeRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  HomeRemoteDataSourceFirebase({required this.firebaseFirestore});
  @override
  Future<List<UserModel>> fetchAllUsers({required String userId}) async {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('users').get();
    return querySnapshot.docs
        .where((doc) => doc.id != userId)
        .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<UserModel>> fetchUsersHaveChatWith(
      {required String userId}) async {
    QuerySnapshot chatsSnapshot = await firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('chats')
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
          .collection('users')
          .where('uId', whereIn: batch)
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
  Future<List<UserWithLastMessage>> fetchUsersWithLastMessage(
      {required String userId}) async {
    List<UserWithLastMessage> usersWithLastMessage = [];

    QuerySnapshot usersSnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    for (var userDoc in usersSnapshot.docs) {
      if (userDoc.id != userId) {
        UserModel user =
            UserModel.fromJson(userDoc.data() as Map<String, dynamic>);

        CollectionReference messagesRef = firebaseFirestore
            .collection('users')
            .doc(userId)
            .collection('chats')
            .doc(userDoc.id)
            .collection('messages');

        // Fetch the last message
        QuerySnapshot chatSnapshot = await messagesRef
            .orderBy('dateTime', descending: true)
            .limit(1)
            .get();

        // Count unread messages where receiver is the current user and isSeen is false
        QuerySnapshot unreadSnapshot = await messagesRef
            .where('receiver', isEqualTo: userId)
            .where('isSeen', isEqualTo: false)
            .get();

        int unreadCount = unreadSnapshot.docs.length;
        if (chatSnapshot.docs.isNotEmpty) {
          usersWithLastMessage.add(
            UserWithLastMessage(
              user: user,
              lastMessage: chatSnapshot.docs.first['text'],
              unreadCount: unreadCount,
            ),
          );
        }
      }
    }

    return usersWithLastMessage;
  }

  @override
  Stream<List<MessageModel>> fetchMessages({
    required UserModel receiver,
    required String userId,
  }) {
    return firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('chats')
        .doc(receiver.uId)
        .collection('messages')
        .orderBy('dateTime')
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
        .collection('users')
        .doc(userId)
        .collection('chats')
        .doc(receiver.uId)
        .collection('messages')
        .add(message.toMap());
    // save massage in receiver document

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiver.uId)
        .collection('chats')
        .doc(userId)
        .collection('messages')
        .add(message.toMap());
// just a value added to document to be active
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('chats')
        .doc(receiver.uId)
        .set({'exists': ''});
// just a value added to document to be active

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiver.uId)
        .collection('chats')
        .doc(userId)
        .set({'exists': ''});
  }

  @override
  Future<void> markAllMessagesSeen(
      {required String userId, required String receiverUId}) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Reference to the messages collection
    final CollectionReference messagesRef = firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('chats')
        .doc(receiverUId)
        .collection('messages');

    // Query to fetch all unread messages
    Query query = messagesRef.where('isSeen', isEqualTo: false);

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
        writeBatch.update(doc.reference, {'isSeen': true});
      }

      // Commit the batch
      await writeBatch.commit();
    }

    print('All unread messages have been marked as read.');
  }
}
