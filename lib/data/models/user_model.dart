import 'dart:convert';

UserModel UserModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String UserModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String email;
  final String firstName;
  final String lastName;
  final String userId;

  const UserModel(
    this.email,
    this.firstName,
    this.lastName,
    this.userId,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        json["email"],
        json["firstName"],
        json["lastName"],
        json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "userId": userId,
      };

  static UserModel get defaultUser => UserModel(
        '',
        '',
        '',
        '',
      );

  static const empty = UserModel('', '', '', '');
}
