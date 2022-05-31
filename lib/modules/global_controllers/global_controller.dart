import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/modules/features/conection_check/view/conection_check.dart';
import 'package:uni_links/uni_links.dart';

class GlobalController extends GetxController{
  static GlobalController get to=> Get.find();
  ///dari Connectivty pluss
  final Connectivity _connentivity = Connectivity();

  RxBool internetstatus=RxBool(true);

  void onInit(){
    super.onInit();
    checkConnectivity();
    _connentivity.onConnectivityChanged.listen(_updateConnectivity);

  }
  ///untuk menampilakan internet dialog
  Future<void> showAlert() async {
    await Get.defaultDialog(
      title: 'error'.tr,
      content: const ConectionCheck(),
    );
  }
  ///uptdate status konektivitas
  void _updateConnectivity(ConnectivityResult result){
    switch (result){
        case ConnectivityResult.mobile:
          internetstatus.value=true;
          break;
        case ConnectivityResult.wifi:
          internetstatus.value=true;
          break;
          default:
            internetstatus.value=false;
            if(Get.currentRoute!=AppRoutes.SplashView){
              showAlert();
            }
            break;

    }
  }
  /// Memerikas Konektivitas
  void checkConnectivity(){
  _connentivity.checkConnectivity().then(_updateConnectivity);
  }

  // Future<void>processUnilink(Uri? uri)async{
  //   if(uri is Uri && uri.queryParameters['id_promo']!=null){
  //     await Get.toNamed(App.routes)
  //   }
  // }
  //
  // Future <void> initUnilinks()async{
  //   getUriLinksStream.listen(pr)
  // }
}