import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/modules/features/dasboard/repositories/promo_repositories.dart';
import 'package:magang/modules/features/loading_location/view/location_view.dart';
import 'package:magang/utils/services/location_service.dart';

import '../../../models/menu_model.dart';
import '../../../models/promo_model.dart';
import '../../sign_in/repository/menu_repo.dart';

class DashboardController extends GetxController{
  static DashboardController get to=>Get.find();

@override
  void onReady(){
    super.onReady();

    Future.delayed(const Duration(milliseconds: 500), getLocation);
    LocationServices.streamService.listen((status) => getLocation());

  }
  ///Navbar index
  RxInt tabIndex = RxInt(0);

  /// Change tab index
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }


  /// Location variables
  RxString statusLocation = RxString('loading');
  RxString messageLocation = RxString('');
  Rxn<Position> position = Rxn<Position>();
  RxnString address = RxnString();

  Future<void> getLocation() async {
    if (Get.isDialogOpen == false) {
      Get.dialog(const LoadingLocation(), barrierDismissible: false);
    }

    try {
      /// Mendapatkan lokasi saat ini
      statusLocation.value = 'loading';
      final locationResult = await LocationServices.getCurrentPosition();

      if (locationResult.success) {
        /// Jika jarak lokasi cukup dekat, dapatkan informasi alamat
        position.value = locationResult.position;
        address.value = locationResult.address;
        statusLocation.value = 'success';

        await Future.delayed(const Duration(seconds: 1));
        Get.until((route) => Get.isDialogOpen == false);
      } else {
        /// Jika jarak lokasi tidak cukup dekat, tampilkan pesan
        statusLocation.value = 'error';
        messageLocation.value = locationResult.message!;
      }
    } catch (e) {
      /// Jika terjadi kesalahan server
      statusLocation.value = 'error';
      messageLocation.value = 'Server error'.tr;
    }
  }
}





