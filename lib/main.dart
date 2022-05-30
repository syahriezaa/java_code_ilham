import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/modules/global_controllers/global_conection.dart';
import 'package:magang/modules/global_controllers/network_binding.dart';


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

  final GlobalConection globalConection= Get.find<GlobalConection>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title:"Java Code",
      initialBinding: NetworkBinding() ,
      initialRoute: AppRoutes.LoginView ,
      getPages: AppPages.pages(),

    );
  }
}
