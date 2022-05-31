import 'package:easy_debounce/easy_debounce.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:magang/config/routes/app_routes.dart';

class DashboardController extends GetxController{
  static DashboardController get to=>Get.find();

  void onReady(){
    super.onReady();

    Future.delayed(const Duration(milliseconds:500),()async{
      Get.toNamed(AppRoutes.LoadingLocation);
      //await getLocation();
    });
  }
  ///Navbar index
  RxInt tabIndex = RxInt(0);

  /// Change tab index
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }


}

