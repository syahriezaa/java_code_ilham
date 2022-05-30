import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang/modules/features/sign_in/repository/login_repo.dart';
import '../../../../constant/common/firebase_cons.dart';
import '../../../models/auth_model.dart';
import '../repository/login_repo.dart';


class LoginControllers extends GetxController{
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  LoginRepo _loginRepo=LoginRepo();
  void login(){
    Auth user=Auth(email: (emailEditingController.text), password: passwordEditingController.text);
    _loginRepo.login(user.email, user.password);
  }



}