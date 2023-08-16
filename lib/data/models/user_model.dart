import 'dart:convert';

UserModel UserModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String UserModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String email;
  String firstName;
  String lastName;
  String userId;

  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "userId": userId,
      };

  static UserModel get defaultUser => UserModel(
        email: '',
        firstName: '',
        lastName: '',
        userId: '',
      );
}
