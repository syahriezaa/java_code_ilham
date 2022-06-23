import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:magang/constant/core/apis_const/api_constant.dart';
import 'package:magang/modules/models/keranjang.dart';
import 'package:magang/utils/services/api_service/login_api.dart';
import 'package:magang/utils/services/local_db_service/local_db_service.dart';

class OrderRepository {
  OrderRepository._();

  /// Memanggil API untuk mendapatkan semua menu
  static Future<Response?> add(CartRequest cartReq) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDbService.getToken());
      var response = await dio.post(
        ApiConstant.addOrder,
        data: json.encode(cartReq.toMap()),
      );
      print("response: " + response.data.toString());

      return response;
    } on DioError {
      print("error: ");
      return null;
    }
  }
  /// Memanggil API untuk membatalkan  menu
  static Future<int> cancel(int id) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDbService.getToken());
      var response = await dio.post(
        ApiConstant.cancelOrder + "/$id",
      );
      var status = response.data['status_code'];
      return status;
    } on DioError {
      print("error: ");
      print(DioError);
      return 500;
    }
  }
}