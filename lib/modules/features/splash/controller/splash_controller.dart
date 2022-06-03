import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

import '../../../../utils/services/local_db_service/local_db_service.dart';
import '../../../global_controllers/global_controller.dart';

class SplashController extends GetxController{
  static SplashController get to=> Get.find<SplashController>();
  
  Future<void> onInit() async {
   super.onInit();

    await Future.delayed(const Duration(seconds: 1));
    var user = await LocalDbService.GetUser();
    var token = await LocalDbService.getToken();
    var uri = await getInitialUri();

    // if (!GlobalController.to.internetstatus.value){
    //   await GlobalController.to.showAlert();
    // }
    if (user!=null &&token != null){
      if (uri is Uri){
        Get.offAllNamed('/dashboard_view');
      }else{
        Get.offAllNamed('/dashboard_view');
      }
    }else{
      Get.offAllNamed('/login');
    }

  }
}