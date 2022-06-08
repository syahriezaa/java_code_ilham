import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:magang/utils/services/api_service/login_api.dart';

import '../../../../utils/services/local_db_service/local_db_service.dart';
import '../../../models/promo_model.dart';


class PromoRepoId{
  PromoRepoId._();

  static Future<PromoResponse> getPromoById(int id_promo) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDbService.getToken());
      var response = await Dio().get('https://api.myjson.com/bins/1hjv0u');
      return PromoResponse.fromJson(response.data);
      print(response.data);
    } on DioError {
      return PromoResponse(status_code: 500, message: "Server error");
    }
  }
}