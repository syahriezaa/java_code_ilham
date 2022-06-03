import 'dart:io';
import 'package:get/get.dart';
import 'package:magang/modules/features/dasboard/repositories/promo_repositories.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../constant/common/constants.dart';
import '../../../models/promo_model.dart';

class PromoByIdController extends GetxController{
  static PromoByIdController get to => Get.find();

  RxString status=RxString('loading');
  Rxn<PromoData> promo=Rxn<PromoData>();

  void onInit(){
    super.onInit();

    if (Get.arguments is PromoData){
      status.value = 'success';
      promo.value = Get.arguments as PromoData;
    }else if(Get.arguments is int){
      setUsingId(Get.arguments as int);
    }
  }

  
  Future<void> setUsingId(int id) async{
    final promoRes = await PromoRepo.getFromId(id);

    if(promoRes.status_code==200){
      promo.value=promoRes.data;
      status.value='success';
  } else if(Get.arguments is int){
    status.value='error';
  }
  }

  ScreenshotController screenshotController = ScreenshotController();

  Future<void>sharePromo()async{
    if (promo.value==null) return;

    final directory = (await getApplicationDocumentsDirectory()).path;
    String fileName ='${DateTime.now().microsecondsSinceEpoch}.png';
    String path = '$directory/$fileName';
    
    await screenshotController.captureAndSave(directory);
    await Share.shareFiles([path],text: 'Get this promo'.trParams({
      'link':'$appDeeplink?id=${promo.value!.id_promo}'
    })
    );
  }


}
