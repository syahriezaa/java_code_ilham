
class Diskon{
  final int id_diskon;
  final int id_user;
  final String nama_user;
  final String nama;
  final int nominal;

  Diskon({
    required this.id_diskon,
    required this.id_user,
    required this.nama_user,
    required this.nama,
    required this.nominal
  });

  factory Diskon.fromJson(Map<String, dynamic> json){
    return Diskon(
      id_diskon: json['id_diskon'] as int,
      id_user: json['id_user'] as int,
      nama_user: json['nama_user'] as String,
      nama: json['nama'] as String,
      nominal: json['nominal'] as int
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id_diskon': id_diskon,
      'id_user': id_user,
      'nama_user': nama_user,
      'nama': nama,
      'nominal': nominal
    };
  }

}
class DiskonResponse{
  final int status_code;
  final String? message;
  final List<Diskon>? data;

  const DiskonResponse({
    required this.status_code,
    this.message,
    this.data,
  });
  ///From json

  factory DiskonResponse.fromJson(Map<String, dynamic> json) {
    return DiskonResponse(
      status_code: json['status_code'] as int,
      message: json['message'] as String?,
      data: json['status_code'] == 200
          ? json['data'].map<Diskon>((e) => Diskon.fromJson(e)).toList()
          : null,
    );
  }
}