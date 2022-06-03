
import 'package:magang/constant/core/assets_conts/asset_cons.dart';

class MenuData{
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

