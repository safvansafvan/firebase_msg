class UserModel {
  UserModel({
    required this.uid,
    required this.email,
    required this.userName,
  });

  final String uid;
  final String email;
  final String userName;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'user_name': userName,
      };
}
