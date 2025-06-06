import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/features/home/data/models/message_model.dart';

import '../../../../core/networking/sources/sources.dart';

class AuthRepository {
  final HomeRemoteDataSource remoteDataSource;
  AuthRepository({required this.remoteDataSource});

  Future<UserModel?> signInWithGoogle() async {
    return await remoteDataSource.signInWithGoogle();
  }

  Stream<List<MessageModel>> fetchMessages(
      {required UserModel receiver, required String userId}) {
    return remoteDataSource.fetchMessages(receiver: receiver, userId: userId);
  }

  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.loginWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    return await remoteDataSource.registerWithEmailAndPassword(
        email: email, password: password, name: name);
  }

  Future<void> updateUserLastSeen({required String uId}) async {
    await remoteDataSource.updateUserLastSeen(uId: uId);
  }
}
