class VoucherData{
  final int id_voucher;
  final int id_user;
  final String nama;
  final String nama_user;
  final int nominal;
  final String info_voucher;
  final DateTime periode_mulai;
  final DateTime periode_selesai;
  final int type;
  final int status;
  final String? catatan;

  const VoucherData({
    required this.id_voucher,
    required this.id_user,
    required this.nama,
    required this.nama_user,
    required this.nominal,
    required this.info_voucher,
    required this.periode_mulai,
    required this.periode_selesai,
    required this.type,
    required this.status,
    this.catatan,
  });

  factory VoucherData.fromJson(Map<String, dynamic> json) {
    return VoucherData(
      id_voucher: json['id_voucher'] as int,
      id_user: json['id_user'] as int,
      nama: json['nama'] as String,
      nama_user: json['nama_user'] as String,
      nominal: json['nominal'] as int,
      info_voucher: json['info_voucher'] as String,
      periode_mulai: DateTime.parse(json['periode_mulai'] as String),
      periode_selesai: DateTime.parse(json['periode_selesai'] as String),
      type: json['type'] as int,
      status: json['status'] as int,
      catatan: json['catatan'] as String,
    );
  }
}

class VoucherResponse{
  final int  status_code;
  final String? message;
  final List<VoucherData>? data;

  VoucherResponse({
    required this.status_code,
    this.message,
    this.data,
  });

  factory VoucherResponse.fromJson(Map<String, dynamic> json) {
    return VoucherResponse(
      status_code: json['status_code'] as int,
      message: json['message'] as String?,
      data: json['status_code'] == 200
          ? json['data'].map<VoucherData>((e) => VoucherData.fromJson(e)).toList()
          : null, );
  }
}
