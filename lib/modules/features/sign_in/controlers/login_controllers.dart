import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang/modules/features/sign_in/repository/login_repo.dart';
import '../../../../constant/common/firebase_cons.dart';
import '../../../models/auth_model.dart';
import '../../loading_location/view/location_view.dart';
import '../repository/login_repo.dart';


class LoginControllers extends GetxController{

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  LoginRepo _loginRepo=LoginRepo();

  Future <void> login()async{
    Auth user=Auth(email: (emailEditingController.text), password: passwordEditingController.text);
    UserRes result= await _loginRepo.login(user.email, user.password);
    if(result.status_code==200){
      Get.off(LoadingLocation());
    }
    else{
        print(result.status_code);
    }
  }



}