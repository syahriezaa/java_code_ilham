import 'package:magang/config/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../modules/features/sign_in/view/ui/Login.dart';


class AppPages{
  static List<GetPage>pages(){
    return[
      GetPage(
        name: AppRoutes.LoginView,
        page:()=>LoginView(),
      )
    ];
  }

}