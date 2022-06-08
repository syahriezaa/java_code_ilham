import 'dart:core';
import 'package:magang/utils/extensions/currency_extension.dart';
import 'package:magang/utils/extensions/string_case_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:get/get.dart';
import 'package:equatable/equatable.dart';

class PromoResponse{
  final int? status_code;
  final String? message;
  final PromoData? data;
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
          ? json['data'].map<PromoData>((e) => PromoData.fromJSON(e)).toList()
          : null,
    );
  }


}
class PromoData extends Equatable{
  int id_promo;
  String nama;
  String type;
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
      this.diskon,
      required this.nominal,
      required this.kadauarsa,
      required this.syarat_ketentuan,
      required this.foto,
      required this.created_at,
      required  this.created_by,
      required this.is_deleted});

  factory PromoData.fromJSON(Map<String, dynamic> json) {
    return PromoData(
      id_promo:json["id_promo"]as int,
      nama: json["nama"],
      type: json["type"],
      diskon: json["diskon"]as int?,
      nominal: json["nominal"]as int?,
      kadauarsa: json["kadauarsa"],
      syarat_ketentuan: json["syarat_ketentuan"],
      foto: json["foto"] as String?,
      created_at: json["created_at"] as int,
      created_by: json["created_by"] as int,
      is_deleted: json["is_deleted"] as int,
    );
  }

  Map<String, dynamic> toJson() {
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
  String get typeLabel => type.tr.toTitleCase();

  String get amountLabel => type == 'diskon' ? '$diskon%' : nominal!.toShortK();

  String get typeAmountLabel => '$typeLabel $amountLabel';

  @override
  // TODO: implement props
  List<Object?> get props => [id_promo];
}

class ListPromo{
  final int status_code;
  final String? message;
  final List<PromoData>? data;

  ListPromo({
    required this.status_code,
    this.message,
    this.data
});
  factory ListPromo.fromJSON(Map<String,dynamic>parsedJson){
    return ListPromo(
      status_code:parsedJson["status_code"],
      message:parsedJson["message"],
      data: parsedJson['status_code']==200
        ?parsedJson['data'].map<PromoData>((e)=>PromoData.fromJSON(e)).toList()
          :null,
    );
  }
}



