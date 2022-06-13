
import 'package:magang/modules/models/detail_order.dart';

class Order {
  final int id_order;
  final String no_struk;
  final String nama;
  final int id_voucher;
  final String nama_voucher;
  final int diskon;
  final int potongan;
  final int total_bayar;
  final DateTime tanggal;
  final int status;
  final List<OrderDetail> menu;

  const Order({
    required this.id_order,
    required this.no_struk,
    required this.nama,
    required this.id_voucher,
    required this.nama_voucher,
    required this.diskon,
    required this.potongan,
    required this.total_bayar,
    required this.tanggal,
    required this.status,
    required this.menu,
  });

  /// Harga tanpa diskon
 int get total => total_bayar + potongan;

  /// From json
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id_order: json['id_order'] as int,
      no_struk: json['no_struk'] as String,
      nama: (json['nama'] ?? '') as String,
      id_voucher: (json['id_voucher'] ?? 0) as int,
      nama_voucher: (json['nama_voucher'] ?? '') as String,
      diskon: (json['diskon'] ?? 0) as int,
      potongan: (json['potongan'] ?? 0) as int,
      total_bayar: json['total_bayar'] as int,
      tanggal: DateTime.parse(json['tanggal'] as String),
      status: json['status'] as int,
      menu: (json['menu'] as List)
          .map<OrderDetail>((e) => OrderDetail.fromJson(e))
          .toList(),
    );
  }
}


class ListOrder {
  final int status_code;
  final List<Order>? data;

  const ListOrder({
    required this.status_code,
    this.data,
  });

  /// From json
  factory ListOrder.fromJson(Map<String, dynamic> json) {
    return ListOrder(
      status_code: json['status_code'] as int,
      data: json['status_code'] == 200
          ? json['data'].map<Order>((e) => Order.fromJson(e)).toList()
          : null,
    );
  }
}

class OrderRes {
  final int status_code;
  final Order? data;

  const OrderRes({
    required this.status_code,
    this.data,
  });

  /// From json
  factory OrderRes.fromJson(Map<String, dynamic> json) {
    if (json['status_code'] == 200) {
      json['data']['order']['menu'] = json['data']['detail'];

      return OrderRes(
        status_code: json['status_code'] as int,
        data: Order.fromJson(json['data']['order']),
      );
    } else {
      return OrderRes(status_code: json['status_code'] as int);
    }
  }
}
