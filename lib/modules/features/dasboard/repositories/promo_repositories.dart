import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:magang/modules/models/auth_model.dart';
import 'package:magang/modules/models/promo_model.dart';
import 'package:magang/utils/services/local_db_service/local_db_service.dart';

import '../../../../constant/core/apis_const/api_constant.dart';
import '../../../../utils/services/api_service/login_api.dart';

class PromoRepo{
  PromoRepo._();
  ///Mendapatkan semua promo
 static Future  <ListPromo> getAll() async {
    try {
      var dio =ApiServices.dioCall(token: await LocalDbService.getToken());
      var response = await dio.get(ApiConstant.allPromo);
      print(response.data);
      return ListPromo.fromJSON(response.data);
    }
    on DioError {
      return ListPromo(status_code: 500,message:'server error'.tr);
    }
  }
  ///Mendapatkan promo berdasarkan ID
  Future<PromoResponse> getFromId(int id_promo)async{
    try{
      var dio =ApiServices.dioCall(token: await LocalDbService.getToken());
      var response = await dio.get('${ApiConstant.Promo}/$id_promo');
      return PromoResponse.fromJson(response.data);
    } on DioError{
      return PromoResponse(status_code: 500,message: ' server_error'.tr);
    }
  }


}
