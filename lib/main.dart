import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang/config/routes/app_routes.dart';


import 'config/pages/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title:"Java Code" ,
      initialRoute: AppRoutes.LoginView ,
      getPages: AppPages.pages(),

    );
  }
}
