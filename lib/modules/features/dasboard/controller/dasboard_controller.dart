import 'package:easy_debounce/easy_debounce.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/modules/features/dasboard/repositories/promo_repositories.dart';

import '../../../models/promo_model.dart';

class DashboardController extends GetxController{
  static DashboardController get to=>Get.find();

  void onReady(){
    super.onReady();
    //
    // Future.delayed(const Duration(milliseconds:500),()async{
    //   Get.toNamed(AppRoutes.LoadingLocation);
    //   //await getLocation();
    // });
  }
  ///Navbar index
  RxInt tabIndex = RxInt(0);

  /// Change tab index
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  ///Promo LoginControllers
  ///
  /// Promo var

  RxString statusPromo = RxString('loading');
  RxString messagePromo = RxString(' ');
  RxList<PromoData>listPromo= RxList<PromoData>();

  Future<void> getPromo()async{

    statusPromo.value = 'loading';
    try {
      var listPromoResponse= await PromoRepo.getAll();
      if (listPromoResponse.status_code==200){
        statusPromo.value ="success";
        listPromo.value=listPromoResponse.data!;
      }else if (listPromoResponse.status_code==204){
        statusPromo.value ='error';
        messagePromo.value ='no_data';
      }else {
        statusPromo.value ='error';
        messagePromo.value =listPromoResponse.message ??'unknown_error'.tr;
      }
    }catch (e) {
        statusPromo.value ='error';
        messagePromo.value =e.toString();
    }
  }

  ///Kontroller dari menu
  

}


