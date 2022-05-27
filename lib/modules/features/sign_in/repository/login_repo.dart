import 'package:dio/dio.dart';
import 'package:magang/constant/core/apis_const/api_constant.dart';
import '../../../models/auth_model.dart';
import '/../utils/services/api_service/login_api.dart';
class LoginRepo{
  Future <User>login(String email, String password)async {
    final response = await ApiServices.dioCall().post('/auth/login',data:{email:'email',password:'password'});
    if (response.statusCode==200){
      final userdata=response.data;
      return response.data;
    }
    else{
      return Future.error("unkown Error");
    }
    }
  private Google
  }

