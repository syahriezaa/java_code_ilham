
class MenuData{
  int id_menu;
  String nama;
  String? kategori;
  int? harga;
  String? Deskripsi;
  String? foto;
  int? Status;

  MenuData(
      {required this.id_menu,
      required this.nama,
      this.kategori,
      this.harga,
      this.Deskripsi,
      this.foto,
      this.Status});

  factory MenuData.fromJson(Map<String, dynamic> json) {
    return MenuData(
      id_menu: int.parse(json["id_menu"]),
      nama: json["nama"],
      kategori: json["kategori"],
      harga: int.parse(json["harga"]),
      Deskripsi: json["Deskripsi"],
      foto: json["foto"],
      Status: int.parse(json["Status"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_menu": this.id_menu,
      "nama": this.nama,
      "kategori": this.kategori,
      "harga": this.harga,
      "Deskripsi": this.Deskripsi,
      "foto": this.foto,
      "Status": this.Status,
    };
  }
}

class LisMenutResponse{
  final int status_code;
  final String? meesage;
  final List<MenuData>? data;

  LisMenutResponse({
    required this.status_code,
    this.meesage,
    this.data});

  factory LisMenutResponse.fromJson(Map<String, dynamic> json) {
    return LisMenutResponse(
      status_code: int.parse(json["status_code"]),
      meesage: json["meesage"],
      data: json['status_code']==200
          ?json['data'].map<MenuData>((e)=>MenuData.fromJson(e)).toList()
        :null
    );
  }
//

}

