import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:magang/constant/core/apis_const/api_constant.dart';
import '../../../models/auth_model.dart';
import '/../utils/services/api_service/login_api.dart';
class LoginRepo{

  Future <UserRes>login(String email, String password)async {


    try {
      var response = await ApiServices.dioCall().post(
          ApiConstant.baseUrl+'/auth/login',
          data:{
            email:'email',password:'password'
          });
      return UserRes.fromJSON(response.data);
    }
    on DioError{
      return UserRes(status_code: 500, data: null);
    }
    }

  }

