import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang/modules/features/sign_in/repository/login_repo.dart';
import '../../../../constant/common/firebase_cons.dart';
import '../../../models/auth_model.dart';
import '../repository/login_repo.dart';


class LoginControllers extends GetxController{
  TextEditingController loginEditingController = TextEditingController();
  // final AuthenticationService _authenticationService;
  // final _authenticationStateStream = AuthenticationState().obs;
static LoginControllers intances =Get.find();
late Rx<User?> firebaseUser;

void onReady(){
  super.onReady();
  firebaseUser = Rx<User?>(auth.currentUser);


}
}