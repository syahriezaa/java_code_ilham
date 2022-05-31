import 'package:magang/config/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:magang/modules/features/conection_check/view/conection_check.dart';

import '../../modules/features/loading_location/view/location_view.dart';
import '../../modules/features/sign_in/view/ui/Login.dart';
import '../../modules/features/splash/view/splash_view.dart';


class AppPages{
  static List<GetPage>pages(){
    return[
      GetPage(
        name: AppRoutes.LoginView,
        page:()=>LoginView(),
      ),
      GetPage(
        name: AppRoutes.ConectionView,
        page: ()=>ConectionCheck(),
      ),
      GetPage(
        name : AppRoutes.LoadingLocation,
        page: ()=>LoadingLocation(),
      ),
      GetPage(
        name: AppRoutes.SplashView,
        page: ()=>SplashView(),
      )
    ];
  }

}