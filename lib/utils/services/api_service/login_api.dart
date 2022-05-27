import 'package:dio/dio.dart';
import 'package:magang/constant/core/apis_const/api_constant.dart';


class ApiServices {
  ApiServices._internal();

  static final _singleton = ApiServices._internal();


  // Create Dio
  static Dio dioCall({int connectTimeout = 20000}) {
    String? token;

    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var dio = Dio(
      BaseOptions(
        headers: header,
        baseUrl: ApiConstant.url,
        connectTimeout: connectTimeout,
      ),
    );

    return dio;
  }
}
