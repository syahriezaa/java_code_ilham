import 'package:magang/config/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:magang/modules/features/conection_check/view/conection_check.dart';
import 'package:magang/modules/features/dasboard/view/ui/Dashboard_view.dart';

import '../../modules/features/dasboard/view/ui/Dashboard_view.dart';
import '../../modules/features/dasboard/view/ui/home_view.dart';
import '../../modules/features/loading_location/view/location_view.dart';
import '../../modules/features/menu/view/ui/menu_view.dart';
import '../../modules/features/promo/view/ui/promo_detail.dart';
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
      ),
      GetPage(
        name: AppRoutes.DashboardView,
        page:()=> DashboardView()
      ),
      GetPage(
        name: AppRoutes.HomeView,
        page:()=>HomeView()
      ),
      GetPage(
        name: AppRoutes.PromoDetailView,
        page:()=>PromoDetailView()
      ),
      GetPage(name: AppRoutes.MenuDetailView,
          page: ()=>MenuView()
      ),
    ];
  }

}