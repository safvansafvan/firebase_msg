class UserModel {
  UserModel({
    required this.uid,
    required this.email,
    required this.userName,
    required this.photoUrl,
  });

  final String uid;

  final String email;
  final String userName;
  final String photoUrl;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'user_name': userName,
        'photo_url': photoUrl,
      };
}
