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


   void login(String email, String password)async{
     print(email);
     print(password);
    UserRes result= await LoginRepo.login(email, password);


    if(result.status_code==200){
      await LocalDbService.setUser(result.data!);
      await LocalDbService.setToken(result.token!);
      Get.offAllNamed('/home_view');
    }
    else{
        print(result.status_code);
    }
  }



}