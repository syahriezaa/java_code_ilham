import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:magang/constant/core/apis_const/api_constant.dart';
import 'package:magang/modules/models/auth_model.dart';
import 'package:magang/modules/models/discount_model.dart';
import 'package:magang/utils/services/api_service/login_api.dart';
import 'package:magang/utils/services/local_db_service/local_db_service.dart';

class DiskonRepo{
  DiskonRepo._();

  static Future<DiskonResponse> getAll()async{

    try {
      var dio = ApiServices.dioCall(token: await LocalDbService.getToken());
      var user = await LocalDbService.GetUser() as User;
      var response = await dio.get("${ApiConstant.allDiscountPerUser}/${user.id_user}");
      return DiskonResponse.fromJson(response.data);
    } on DioError {
      return DiskonResponse(status_code: 500, message: "Server error");
    }
  }

}