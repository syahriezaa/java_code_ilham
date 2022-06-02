import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/constant/common/constants.dart';
import 'package:magang/modules/features/splash/controller/splash_controller.dart';
import 'package:magang/modules/global_controllers/global_conection.dart';
import 'package:magang/modules/global_controllers/global_binding.dart';


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

  //final NewworkController globalConection= Get.find<NewworkController>();
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return ScreenUtilInit(
      designSize: appDsignSize,
      builder:(context, _)=> GetMaterialApp(
      title:"Java Code",
      //initialBinding: GlobalBinding() ,
      initialRoute: AppRoutes.SplashView,
      getPages: AppPages.pages(),
    ),
    );

  }
}
