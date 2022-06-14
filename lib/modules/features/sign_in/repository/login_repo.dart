import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:magang/constant/core/apis_const/api_constant.dart';
import '../../../models/auth_model.dart';
import '/../utils/services/api_service/login_api.dart';
class LoginRepo{

  LoginRepo._();
  static final Dio _dio = ApiServices.dioCall();

  static Future <UserRes>login(

      String email, String password)async {
    try {
      var response = await _dio.post(ApiConstant.login, data: {
        'email': email,
        'password': password,
      });

      return UserRes.fromJSON(response.data);
    }
    on DioError{
      return UserRes(status_code: 500, data: null);
    }
    }

  static Future<UserRes> getUserFromGoogle(String nama, String email) async {
    /// Memanggil API login dengan method POST
    try {
      var response = await _dio.post(ApiConstant.login, data: {
        'nama': nama,
        'email': email,
        'is_google': 'is_google',
      });

      return UserRes.fromJSON(response.data);
    } on DioError {
      return UserRes(status_code: 500, message: 'Server error'.tr);
    }
  }
  }

