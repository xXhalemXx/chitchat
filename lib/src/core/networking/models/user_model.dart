class UserModel {
  final String name;
  final String phone;
  final String email;
  final String uId;
  final String photo;
  final String bio;
  final String lastActivity;

  UserModel({
    required this.email,
    required this.phone,
    required this.name,
    required this.uId,
    required this.photo,
    required this.bio,
    required this.lastActivity,
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
    );
  }

  copyWith({
    String? name,
    String? phone,
    String? email,
    String? uId,
    String? photo,
    String? bio,
    String? lastActivity,
  }) {
    return UserModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      uId: uId ?? this.uId,
      photo: photo ?? this.photo,
      bio: bio ?? this.bio,
      lastActivity: lastActivity ?? this.lastActivity,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'uId': uId,
        'photo': photo,
        'bio': bio,
        'lastActivity': lastActivity,
      };
}
