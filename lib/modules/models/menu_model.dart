
import 'package:equatable/equatable.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';

class MenuData extends Equatable{
  final int id_menu;
  final String nama;
  final String  kategori;
  final int harga;
  final String  deskripsi;
  final String foto;
  final int status;

  MenuData({
    required this.id_menu,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.foto,
    required this.status});

  factory MenuData.fromJson(Map<String, dynamic> json) {
    return MenuData(
      id_menu: json["id_menu"]as int,
      nama: json["nama"] as String,
      kategori: json["kategori"] as String,
      harga: json["harga"]as int ,
      deskripsi: json["deskripsi"] as String,
      foto: (json['foto'] ??AssetCons.defaultFoodImage) as String,
      status: json["status"]as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_menu": this.id_menu,
      "nama": this.nama,
      "kategori": this.kategori,
      "harga": this.harga,
      "deskripsi": this.deskripsi,
      "foto": this.foto,
      "status": this.status,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id_menu];
}

class LisMenutResponse{
  final int status_code;
  final String? message;
  final List<MenuData>? data;

  LisMenutResponse({
    required this.status_code,
    this.message,
    this.data});

  factory LisMenutResponse.fromJson(Map<String, dynamic> json) {
    return LisMenutResponse(
      status_code: json["status_code"]as int,
      message: json["message"],
      data: json['status_code']==200
          ?json['data'].map<MenuData>((e)=>MenuData.fromJson(e)).toList()
        :null
    );
  }
//
}

class MenuVariant {
  final int id_detail;
  final String keterangan;
  final String type;
  final int harga;

  MenuVariant({
    required this.id_detail,
    required this.keterangan,
    required this.type,
    required this.harga,
  });

  factory MenuVariant.fromJson(Map<String, dynamic> json) {
    return MenuVariant(
      id_detail: json["id_detail"]as int,
      keterangan: json["keterangan"] as String,
      type: json["type"] as String,
      harga: json["harga"]as int,
    );
    }
    Map<String,dynamic>toMap(){
    return{
      'id_detail':id_detail,
      'keterangan':keterangan,
      'type':type,
      'harga':harga,
    };
    }

}

class MenuRes{
  final int status_code;
  final String? message;
  final MenuData? data;
  final List<MenuVariant> topping;
  final List<MenuVariant> level;

  MenuRes({
    required this.status_code,
    this.message,
    this.data,
    this.topping =const <MenuVariant>[],
    this.level = const <MenuVariant>[],
  });

  factory MenuRes.fromJson(Map<String, dynamic> json) {
    return MenuRes(
      status_code: json['status_code'] as int,
      message: json['message'] as String?,
      data: json['status_code'] == 200
          ? MenuData.fromJson(json['data']['menu'])
          : null,
      topping: json['status_code'] == 200 && json['data']['topping'] is List
          ? json['data']['topping']
          .map<MenuVariant>((e) => MenuVariant.fromJson(e))
          .toList()
          : const <MenuVariant>[],
      level: json['status_code'] == 200 && json['data']['level'] is List
          ? json['data']['level']
          .map<MenuVariant>((e) => MenuVariant.fromJson(e))
          .toList()
          : const <MenuVariant>[],
    );
  }
}

