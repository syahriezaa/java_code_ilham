import 'package:easy_debounce/easy_debounce.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/modules/features/dasboard/repositories/promo_repositories.dart';
import 'package:magang/modules/features/loading_location/view/location_view.dart';
import 'package:magang/utils/services/location_service.dart';

import '../../../models/menu_model.dart';
import '../../../models/promo_model.dart';
import '../../sign_in/repository/menu_repo.dart';

class DashboardController extends GetxController{
  static DashboardController get to=>Get.find();

  void onReady(){
    super.onReady();

    Future.delayed(const Duration(milliseconds:500),()async{
      Get.dialog(const LoadingLocation(), barrierDismissible: false);
      await getLocation();
    });
    getPromo();
    getListMenu();
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
        print(listPromoResponse.data!);
      }else if (listPromoResponse.status_code==204){
        statusPromo.value ='error';
        messagePromo.value ='no_data';
      }else {
        statusPromo.value ='error';
        messagePromo.value =listPromoResponse.message ??'unknown_error'.tr;
      }
    }catch (e,stack) {
        statusPromo.value ='error';
        messagePromo.value =e.toString();
        print(stack);
    }
  }

  ///Kontroller dari menu


  ///dekalirasi variabel menu
  RxString categoryMenu = RxString('all');
  RxString filterMenu = RxString('');
  RxString statusMenu = RxString('loading');
  RxString messageMenu = RxString('');
  RxList<MenuData> listMenu = RxList<MenuData>();



  /// mendapatkan data menu
  Future<void> getListMenu() async {
    statusMenu.value = 'loading';
    try {
      var listMenuRes = await MenuRepository.getAll();
      print("get All RUN");
      if (listMenuRes.status_code == 200) {
        statusMenu.value = 'success';
        listMenu.value = listMenuRes.data!;
      } else if (listMenuRes.status_code == 204) {
        statusMenu.value = 'error';
        messageMenu.value = 'no_data'.tr;
      } else {
        statusMenu.value = 'error';
        messageMenu.value = listMenuRes.message ?? 'unknown_error'.tr;
      }
    } catch (e,stack) {
      statusMenu.value = 'error';
      messageMenu.value = e.toString();
      print(stack);
    }
  }

  /// Get food list
  List<MenuData> get foodMenu => _getListMenuByFilter('makanan');

  /// Get drink list
  List<MenuData> get drinkMenu => _getListMenuByFilter('minuman');

  List<MenuData> _getListMenuByFilter(String category) {
    return listMenu
        .where((e) =>
    e.kategori == category &&
        e.nama.toLowerCase().contains(filterMenu.value.toLowerCase()))
        .toList();
  }

  /// Cart
  RxMap<int, int> quantities = RxMap<int, int>();
  RxMap<int, String> notes = RxMap<int, String>();

  /// Location variables
  RxString statusLocation = RxString('loading');
  RxString messageLocation = RxString('');
  Rxn<Position> position = Rxn<Position>();
  RxnString address = RxnString();

  Future<void> getLocation() async {
    try {
      /// Mendapatkan lokasi saat ini
      position.value = await LocationServices.getCurrentPosition();

      if (LocationServices.isDistanceClose(position.value!)) {
        /// Jika jarak lokasi cukup dekat, dapatkan informasi alamat
        address.value = await LocationServices.getAddress(position.value!);
        statusLocation.value = 'success';

        await Future.delayed(const Duration(seconds: 1));
        Get.until((route) => Get.isDialogOpen == false);
      } else {
        /// Jika jarak lokasi tidak cukup dekat, tampilkan pesan
        statusLocation.value = 'error';
        messageLocation.value = 'Distance not close'.tr;
      }
    } catch (e) {
      /// Jika terjadi kesalahan server
      statusLocation.value = 'error';
      messageLocation.value = 'Server error'.tr;
    }
  }

}





