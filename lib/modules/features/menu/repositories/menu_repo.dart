import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:magang/constant/core/apis_const/api_constant.dart';
import 'package:magang/modules/models/menu_model.dart';
import 'package:magang/utils/services/api_service/login_api.dart';
import 'package:magang/utils/services/local_db_service/local_db_service.dart';



class MenuRepo{
  MenuRepo._();

  ///memnanggi API untuk mengambil data menu berdasarkan id

static Future<MenuRes> getMenuById(int id_menu) async {
  try {
    var dio = ApiServices.dioCall(token: await LocalDbService.getToken());
    var response = await dio.get('${ApiConstant.menu}/$id_menu');
    return MenuRes.fromJson(response.data);
  } on DioError {
    return MenuRes(status_code: 500, message: ' server_error'.tr);
  }
}
}