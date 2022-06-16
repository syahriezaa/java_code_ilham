import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:magang/config/localization/localization.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/config/themes/light_theme.dart';
import 'package:magang/constant/common/constants.dart';
import 'package:magang/modules/features/splash/controller/splash_controller.dart';
import 'package:magang/modules/global_controllers/global_conection.dart';
import 'package:magang/modules/global_controllers/global_binding.dart';


import 'config/pages/app_pages.dart';
import 'constant/core/apis_const/api_constant.dart';

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
    return ScreenUtilInit(
      designSize: AppConstant.appDesignSize,
      builder:(context, _)=> GetMaterialApp(
        title:"Java Code",
        initialBinding: GlobalBinding() ,
        initialRoute: AppRoutes.SplashView,
        theme: AppTheme.lightTheme,
        getPages: AppPages.pages(),
        translations: Localization(),
        locale:Localization.locale,
        fallbackLocale: Localization.fallbackLocale,
        localizationsDelegates: const[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: Localization.locales,
    ),
    );

  }
}
