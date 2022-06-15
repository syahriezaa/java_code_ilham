import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ConectionCheck extends StatelessWidget {
  const ConectionCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            Container(
              child: Image.asset('assets/images/conection_error.jpg'),
            ),
            Container(
              child: Text('No Connection Available'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20)),
            )

          ],
        )

      ),
    );
  }
}
