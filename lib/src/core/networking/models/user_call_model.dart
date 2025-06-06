import 'package:chitchat/src/core/networking/models/user_model.dart';

/// simple model for call user
/// using name ,photo and id
class UserCallModel {
  final String name;
  final String photo;
  final String uId;

  UserCallModel({required this.name, required this.photo, required this.uId});

  factory UserCallModel.fromJson(Map<String, dynamic> json) {
    return UserCallModel(
      name: json['name'],
      photo: json['photo'],
      uId: json['uId'],
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'photo': photo, 'uId': uId};

  factory UserCallModel.convertUserModelToUserCallModel(UserModel userModel) {
    return UserCallModel(
      name: userModel.name,
      photo: userModel.photo,
      uId: userModel.uId,
    );
  }
}
