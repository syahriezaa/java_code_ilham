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

class User{
  int idUser;
  String email;
  String nama;
  String pin;
  String foto;
  int mRolesId;
  int isGoogle;
  int isCostumer;
  String roles;
  List <String> akses;

User({
  required this.idUser,
  required this.email,
  required this.nama,
  required this.pin,
  required this.foto,
  required this.mRolesId,
  required this.isGoogle,
  required this.isCostumer,
  required this.roles,
  required this.akses});

  factory User.fromJSON(Map<String, dynamic>parsedJson){
    return User(
      idUser : parsedJson['id_user'],
      email : parsedJson['email'],
      nama :parsedJson['nama'],
      pin : parsedJson['pin'],
      foto :parsedJson['foto'],
      mRolesId :parsedJson['m_roles_id'],
      isGoogle :parsedJson['is_google'],
      isCostumer :parsedJson ['is_costumer'],
      roles :parsedJson['roles'],
      akses :parsedJson['akses']
    );
  }
  Map<String,dynamic>toJson()=>{
    'id_user':idUser,
    'email':email,
    'nama':nama,
    'pin':pin,
    'foto':foto,
    'm_roles_id':mRolesId,
    'is_google': isGoogle,
    'is_costumer': isCostumer,
    'roles': roles,
    'akses' : akses,
  };
}
class GoogleAuth{
  int id_user;
  String email;
  String nama;
  int m_roles_id;
  bool is_google;



  GoogleAuth({required this.id_user, required this.email, required this.nama, required this.m_roles_id, required this.is_google});
}
