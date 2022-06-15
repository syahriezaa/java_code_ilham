import 'dart:convert';

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
  Map<String, dynamic> toJson(Auth data) => {
    "email": email,
    "password":password,
  };
}

class User{
  int? id_user;
  String email;
  String nama;
  DateTime? tgl_lahir;
  String? alamat;
  String? telepon;
  String? ktp;
  String? foto;
  String pin;
  int? isCostumer;
  String? roles;

User({
  required this.id_user,
  required this.email,
  required this.nama,
  required this.tgl_lahir,
  required this.alamat,
  required this.telepon,
  required this.ktp,
  required this.foto,
  required this.pin,
});

  factory User.fromJSON(Map<String, dynamic>parsedJson){
    return User(
      id_user      :parsedJson['id_user'],
      email       :parsedJson['email'],
      nama        :parsedJson['nama'],
      tgl_lahir   :parsedJson['tgl_lahir'] != null
          ? DateTime.parse(parsedJson['tgl_lahir'] as String)
          : null,
      alamat      :parsedJson['alamat'],
      telepon     :parsedJson['telepon'],
      ktp         :parsedJson['ktp'],
      foto        :parsedJson['foto'],
      pin         :parsedJson['pin'],


    );
  }
  Map<String,dynamic>toJson()=>{
    'id_user'       :id_user,
    'email'         :email,
    'nama'          :nama,
    'tgl_lahir'     :tgl_lahir,
    'alamat'        :alamat,
    'telepon'       :telepon,
    'ktp'           :ktp,
    'foto'          :foto,
    'pin'           :pin,
  };

  static User dummy = User(
    id_user: 0,
    email: '',
    nama: '',
    tgl_lahir: null,
    alamat: '',
    telepon: '',
    ktp: '',
    pin: '',
    foto: '',
  );
}

class UserData{
  User? user;
  String? token;
  UserData({required this.user, required this.token});

  factory UserData.fromJSON(Map<String, dynamic> parsedJson) {
    return UserData(
        user : parsedJson['user'],
        token: parsedJson['token']
    );
  }
  Map<String, dynamic> toJson(Auth data) => {
    "user"  : user,
    "token" :token,
  };

}



class UserRes{
  int status_code;
  String? message;
  User?  data;
  String? token;

  UserRes({
  required this.status_code,
  this.data,
  this.message,
  this.token
  }
  );

  factory UserRes.fromJSON(Map<String, dynamic> parsedJson) {
    return UserRes(
        status_code:parsedJson["status_code"],
        message: parsedJson["meesage"],
        data : parsedJson['status_code']==200
            ?User.fromJSON(parsedJson['data']['user'])
            :null,
        token: parsedJson['status_code'] == 200 ? parsedJson['data']['token'] : null,
    );
  }
  factory UserRes.fromJsonProfile(Map<String, dynamic> json) {
    return UserRes(
      status_code: json['status_code'],
      message: json['message'],
      data: json['status_code'] == 200 ? User.fromJSON(json['data']) : null,
    );
  }


  Map<String, dynamic> toJson(Auth data) => {
    "status_code":status_code,
    "data": data,
  };
}

class Akses{
  bool? auth_user;
  bool? auth_akses;
  bool? setting_menu;
  bool? setting_customer;
  bool? setting_promo;
  bool? setting_diskon;
  bool? setting_voucher;
  bool? laporan_menu;
  bool? laporan_costumer;

  Akses({
    required this.auth_akses,
    required this.auth_user,
    required this.laporan_costumer,
    required this.laporan_menu,
    required this.setting_customer,
    required this.setting_diskon,
    required this.setting_menu,
    required this.setting_promo,
    required this.setting_voucher
  });
  factory Akses.fromJSON(Map<String, dynamic> parsedJson) {
    return Akses(
        auth_akses: parsedJson["auth_akses"],
        auth_user: parsedJson["auth_user"],
        laporan_costumer: parsedJson["laporan_costumer"],
        laporan_menu: parsedJson["laporan_menu"],
        setting_customer: parsedJson["setting_customer"],
        setting_diskon: parsedJson["setting_diskon"],
        setting_menu  :  parsedJson["setting_menu"],
        setting_promo : parsedJson["setting_promo"],
        setting_voucher: parsedJson["setting_voucher"]
    );
  }
  Map<String, dynamic> toJson(Auth data) => {
    "auth_akses": auth_akses,
    "auth_user": auth_user,
    "laporan_costumer": laporan_costumer,
    "laporan_menu":laporan_menu,
    "setting_customer":setting_customer,
    "setting_diskon":setting_diskon,
    "setting_menu":setting_menu,
    "setting_promo": setting_promo,
    "setting_voucher":setting_voucher
  };
}


class GoogleAuth{
  int id_user;
  String email;
  String nama;
  int m_roles_id;
  bool is_google;

  GoogleAuth({required this.id_user, required this.email, required this.nama, required this.m_roles_id, required this.is_google});

  factory GoogleAuth.fromJson(Map<String, dynamic> json) {
    return GoogleAuth(
      id_user     : int.parse(json["id_user"]),
      email       : json["email"],
      nama        : json["nama"],
      m_roles_id  : int.parse(json["m_roles_id"]),
      is_google   : json["is_google"].toLowerCase() == 'true',
    );
  }



  Map<String, dynamic> toJson() {
    return {
      "id_user"   : this.id_user,
      "email"     : this.email,
      "nama"      : this.nama,
      "m_roles_id": this.m_roles_id,
      "is_google" : this.is_google,
    };
  }

}