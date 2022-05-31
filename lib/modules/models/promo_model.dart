import 'dart:core';
import 'package:java_code_app/utils/extensions/currency_extension.dart';
import 'package:java_code_app/utils/extensions/string_case_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:get/get.dart';

class PromoResponse{
  final int? status_code;
  final String? message;
  final List<PromoData>? data;
  PromoResponse({
    required this.status_code,
    this.message,
    this.data
  });

  Map<String, dynamic> toJson() {
    return {
      "statusCode": this.status_code,
    };
  }

  factory PromoResponse.fromJson(Map<String, dynamic> json) {
    return PromoResponse(
      status_code: json['status_code'],
      message: json['message'],
      data: json['status_code'] == 200
          ? json['data'].map<PromoData>((e) => PromoData.fromJson(e)).toList()
          : null,
    );
  }


}
class PromoData{
  int? id_promo;
  String? nama;
  String? type;
  int? diskon;
  int? nominal;
  String? kadauarsa;
  String? syarat_ketentuan;
  String? foto;
  int? created_at;
  int? created_by;
  int? is_deleted;
  PromoData({
      required this.id_promo,
      required this.nama,
      required this.type,
      required this.diskon,
      required this.nominal,
      required this.kadauarsa,
      required this.syarat_ketentuan,
      required this.foto,
      required this.created_at,
      required  this.created_by,
      required this.is_deleted});

  factory PromoData.fromJson(Map<String, dynamic> json) {
    return PromoData(
      id_promo: int.parse(json["id_promo"]),
      nama: json["nama"],
      type: json["type"],
      diskon: int.parse(json["diskon"]),
      nominal: int.parse(json["nominal"]),
      kadauarsa: json["kadauarsa"],
      syarat_ketentuan: json["syarat_ketentuan"],
      foto: json["foto"],
      created_at: int.parse(json["created_at"]),
      created_by: int.parse(json["created_by"]),
      is_deleted: int.parse(json["is_deleted"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id_promo": this.id_promo,
      "nama": this.nama,
      "type": this.type,
      "diskon": this.diskon,
      "nominal": this.nominal,
      "kadauarsa": this.kadauarsa,
      "syarat_ketentuan": this.syarat_ketentuan,
      "foto": this.foto,
      "created_at": this.created_at,
      "created_by": this.created_by,
      "is_deleted": this.is_deleted,
    };
  }
  String get typeLabel => type?.tr.toTitleCase();
  String get amountLabel => type == 'diskon' ? '$diskon%' : nominal!.toShortK();

  String get typeAmountLabel => '$typeLabel $amountLabel';
}

