class UserModel {
  String? name;
  String? email;
  String? birthDate;
  String? uid;
  String? number;
  String? datetime;
  String? url;
  String? lastUpdated;
  UserModel(
      {this.email,
      this.name,
      this.uid,
      this.datetime,
      this.url,
      this.number,
      this.birthDate,
      this.lastUpdated});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'uid': uid,
        'datetime': datetime,
        'url': url,
        'number': number,
        'lastUpdated': lastUpdated,
        'birthDate': birthDate
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      name: json["name"],
      email: json["email"],
      uid: json["uid"],
      url: json['url'],
      number: json['number'],
      birthDate: json['birthDate'],
      lastUpdated: json['lastUpdated'],
      datetime: json['datetime']);
}
