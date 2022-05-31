import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang/modules/features/sign_in/repository/login_repo.dart';
import '../../../../utils/services/local_db_service/local_db_service.dart';
import '../../../models/auth_model.dart';
import '../repository/login_repo.dart';


class LoginControllers extends GetxController{

  static LoginControllers get to=>Get.find<LoginControllers>();

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  LoginRepo _loginRepo=LoginRepo();

  Future <void> login()async{
    Auth user=Auth(email: (emailEditingController.text), password: passwordEditingController.text);
    UserRes result= await _loginRepo.login(user.email, user.password);
    if(result.status_code==200){
      await LocalDbService.setUser(result.data!);
      await LocalDbService.setToken(result.token!);
      Get.offAllNamed('/conection_check');
    }
    else{
        print(result.status_code);
    }
  }



}