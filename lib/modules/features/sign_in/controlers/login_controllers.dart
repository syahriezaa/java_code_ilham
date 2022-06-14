import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:magang/modules/features/sign_in/repository/login_repo.dart';
import 'package:magang/shared/widgets/ErrorSnackBar.dart';
import '../../../../utils/services/local_db_service/local_db_service.dart';
import '../../../models/auth_model.dart';
import '../repository/login_repo.dart';


class LoginControllers extends GetxController{

  static LoginControllers get to=>Get.find<LoginControllers>();

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();


   void login(String email, String password)async{
    UserRes result= await LoginRepo.login(email, password);

    print(result.status_code);
    if(result.status_code==200){
      await LocalDbService.setUser(result.data!);
      await LocalDbService.setToken(result.token!);
      Get.offAllNamed('/dashboard_view');
    }
    else if (result.status_code == 422 || result.status_code == 204){
      Get.showSnackbar(GetSnackBar(
        title: 'Something went wrong'.tr,
        message: 'Incorrect email or password'.tr,
        duration: const Duration(seconds: 2),
      ));
    } else {
      Get.showSnackbar(GetSnackBar(
        title: 'Something went wrong'.tr,
        message: result.message ?? 'Unknown error'.tr,
        duration: const Duration(seconds: 2),
      ));
    }
   }
  void loginWithGoogle() async {
    /// Singleton GoogleSignIn
    final GoogleSignIn googleSignIn = GoogleSignIn();

    /// Sign out dari akun saat ini (apabila ada) dan sign in
    await googleSignIn.signOut();

    GoogleSignInAccount? account = await googleSignIn.signIn();

    if (account == null) throw Exception('error');

    /// Memanggil API repository
    UserRes userRes = await LoginRepo.getUserFromGoogle(
        account.displayName ?? '-', account.email);

    if (userRes.status_code == 200) {
      /// Mengatur token dan user
      await LocalDbService.setUser(userRes.data!);
      await LocalDbService.setToken(userRes.token!);

      /// Pergi ke halaman dashboard
      Get.offNamed('/dashboard_view');
    } else if (userRes.status_code == 422 || userRes.status_code == 204) {
      /// Tampilkan snackbar jika username atau password salah
      Get.showSnackbar(ErrorSnackBar(
        title: 'Something went wrong'.tr,
        message: 'Email or password is incorrect'.tr,
      ));
    } else {
      Get.showSnackbar(ErrorSnackBar(
        title: 'Something went wrong'.tr,
        message: 'Unknown error'.tr ,
      ));
    }
  }


}