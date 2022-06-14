import 'package:dio/dio.dart';
import 'package:magang/constant/common/constants.dart';
import 'package:magang/constant/core/apis_const/api_constant.dart';
import 'package:magang/modules/models/auth_model.dart';
import 'package:magang/utils/services/api_service/login_api.dart';
import 'package:magang/utils/services/local_db_service/local_db_service.dart';

class ProfileRepo{
  ProfileRepo._();

/// Memanggil API untuk mendapatkan user berdasarkan ID
  static Future<UserRes> get() async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDbService.getToken());
      var user = await LocalDbService.GetUser() as User;
      var response = await dio.get('${ApiConstant.detailUser}/${user.id_user}');

      return UserRes.fromJSON(response.data);
    } on DioError {
      return UserRes(status_code: 500);
    }
  }
  static Future<UserRes> update(Map<String,String>data) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDbService.getToken());
      var user = await LocalDbService.GetUser() as User;
      var response = await dio.post(
          '${ApiConstant.updateUser} /${user.id_user}',
          data:data,) ;
      return UserRes.fromJSON(response.data);
    } on DioError {
      return UserRes(status_code: 500);
    }
  }
  static Future<UserRes> updatePhoto(String photo) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDbService.getToken());
      var user = await LocalDbService.GetUser() as User;
      var response = await dio.post(
        '${ApiConstant.updateUserPhoto}/${user.id_user}',
        data: {'image': photo},
      );

      return UserRes.fromJSON(response.data);
    } on DioError {
      return  UserRes(status_code: 500);
    }
  }

}