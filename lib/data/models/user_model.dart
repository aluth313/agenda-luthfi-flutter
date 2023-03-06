import 'package:meta/meta.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.birthdate,
    required this.gender,
    required this.password,
    required this.photo,
  });

  final String firstname;
  final String lastname;
  final String email;
  final String birthdate;
  final String gender;
  final String password;
  final String photo;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        birthdate: json["birthdate"],
        gender: json["gender"],
        password: json["password"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "birthdate": birthdate,
        "gender": gender,
        "password": password,
        "photo": photo,
      };
}
