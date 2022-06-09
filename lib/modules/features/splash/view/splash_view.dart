import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang/modules/features/splash/controller/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Center(
          child: Image.asset('assets/images/logo_login.png',
            width: MediaQuery.of(context).size.width * 0.8,),
      )
    );
  }
}
