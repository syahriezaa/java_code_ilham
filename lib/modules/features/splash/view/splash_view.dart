import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset('assets/images/logo_login.png',
            width: MediaQuery.of(context).size.width * 0.8,),

      )
    );
  }
}
