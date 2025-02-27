class UserModel {
  final String name;
  final String phone;
  final String email;
  final String uId;
  final String photo;
  final String bio;
  final String lastActivity;
  final List callsHistory;

  UserModel({
    required this.email,
    required this.phone,
    required this.name,
    required this.uId,
    required this.photo,
    required this.bio,
    required this.lastActivity,
    required this.callsHistory,
  });

  static UserModel fromJson(Map<String, dynamic> jason) {
    return UserModel(
      email: jason['email'],
      phone: jason['phone'],
      name: jason['name'],
      uId: jason['uId'],
      photo: jason['photo'],
      bio: jason['bio'],
      lastActivity: jason['lastActivity'],
      callsHistory: jason['callsHistory'],
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'email': email,
        'uId': uId,
        'photo': photo,
        'bio': bio,
        'lastActivity': lastActivity,
        'callsHistory': callsHistory,
      };
}
