class UserModel {
  String name;
  String phone;
  String email;
  String uId;
  String photo;
  String bio;

  UserModel({
    required this.email,
    required this.phone,
    required this.name,
    required this.uId,
    required this.photo,
    required this.bio,
  });

  static UserModel fromJason(Map<String, dynamic> jason) {
    return UserModel(
      email: jason['email'],
      phone: jason['phone'],
      name: jason['name'],
      uId: jason['uId'],
      photo: jason['photo'],
      bio: jason['bio'],
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'email': email,
        'uId': uId,
        'photo': photo,
        'bio': bio,
      };
}
