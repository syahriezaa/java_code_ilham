import 'package:json_annotation/json_annotation.dart';

class Auth{
  String email;
  String password;

  Auth({required this.email,required this.password});

  factory Auth.fromJSON(Map<String, dynamic> parsedJson) {
    return Auth(
      email : parsedJson['email'],
      password: parsedJson['password']
    );
  }
  Map<String, dynamic> toJson() => {

    "email": email,
    "password":password,
  };
}

class UserRes{}
class GoogleAuth{
  int id_user;
  String email;
  String nama;
  int m_roles_id;
  bool is_google;

  GoogleAuth({required this.id_user, required this.email, required this.nama, required this.m_roles_id, required this.is_google});
}
