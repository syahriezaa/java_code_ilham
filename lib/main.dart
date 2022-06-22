import 'package:device_preview/device_preview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:magang/config/localization/localization.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/config/themes/light_theme.dart';
import 'package:magang/constant/common/constants.dart';
import 'package:magang/modules/global_controllers/global_binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:magang/utils/services/api_service/login_api.dart';
import 'package:magang/utils/services/notification_service.dart';


import 'config/pages/app_pages.dart';
import 'constant/core/apis_const/api_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /// Firebase
  await Firebase.initializeApp();
  await NotificationServices.init();

  runApp(
      DevicePreview(
          enabled: false,
          builder: (context)=>const MyApp()
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

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
