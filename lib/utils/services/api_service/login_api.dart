import 'package:dio/dio.dart';
import 'package:magang/constant/core/apis_const/api_constant.dart';


class ApiServices {
  ApiServices._internal();

  // Create Dio
  static Dio dioCall({int connectTimeout = 20000, String? token}) {

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers['token'] = token;
    }
    var dio = Dio(
      BaseOptions(
        headers: headers,
        baseUrl: ApiConstant.baseUrl,
        connectTimeout: connectTimeout,
      ),
    );

    return dio;
  }
}
