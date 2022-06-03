import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:magang/constant/core/apis_const/api_constant.dart';

import '../../../../utils/services/api_service/login_api.dart';
import '../../../../utils/services/local_db_service/local_db_service.dart';
import '../../../models/menu_model.dart';

class MenuRepository{
  MenuRepository._();

  static Future<LisMenutResponse> getAll()async{
    try{
      var dio= ApiServices.dioCall(token:await LocalDbService.getToken());
      var response = await dio.get(ApiConstant.allMenu);
      return LisMenutResponse.fromJson(response.data);
    }on DioError{
      return LisMenutResponse(status_code: 500,message:'server error'.tr);
    }
  }

}
