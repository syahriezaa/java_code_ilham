

import 'package:equatable/equatable.dart';
import 'package:magang/constant/common/constants.dart';
import 'package:magang/modules/models/menu_model.dart';

import '../../constant/core/apis_const/api_constant.dart';

class OrderDetail extends Equatable {
  final int id_menu;
  final String kategori;
  final String topping;
  final String nama;
  final String? foto;
  final int jumlah;
  final String harga;
  final int total;
  final String catatan;

  const OrderDetail({
    required this.id_menu,
    required this.kategori,
    required this.topping,
    required this.nama,
    required this.foto,
    required this.jumlah,
    required this.harga,
    required this.total,
    required this.catatan,
  });

  /// Apakah menu ini adalah makanan
  bool get isFood => kategori == AppConstant.foodCategory;

  /// Apakah menu ini adalah minuman
  bool get isDrink => kategori == AppConstant.drinkCategory;

  /// From json
  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id_menu: json['id_menu'] as int,
      kategori: json['kategori'] as String,
      topping: json['topping'] as String,
      nama: json['nama'] as String,
      foto: json['foto'] as String?,
      jumlah: json['jumlah'] as int,
      harga: json['harga'] as String,
      total: json['total'] as int,
      catatan: json['catatan'] as String,
    );
  }

  @override
  List<Object?> get props => [];
}
