import 'package:chitchat/src/core/models/user_model.dart';

class CurrentUserData {
  UserModel currentUser =
      UserModel(email: '', phone: '', name: '', uId: '', photo: '');
  set({required UserModel currentUser}) {
    this.currentUser = currentUser;
  }
}
