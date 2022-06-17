import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:magang/constant/common/constants.dart';
import 'package:magang/modules/models/promo_model.dart';

import '../../../models/menu_model.dart';
import '../../sign_in/repository/menu_repo.dart';
import '../repositories/promo_repositories.dart';


class HomeController extends GetxController {
  static HomeController get to => Get.find();

  late TextEditingController searchController;
  late Debouncer debouncer;

  @override
  void onInit() {
    super.onInit();

    searchController = TextEditingController();
    debouncer = Debouncer(delay: const Duration(milliseconds: 500));

    /// Mendapatkan promo dan menu
    getListPromo();
    getListMenu();
  }

  @override
  void onClose() {
    /// Hentikan timer dan hapus text editing controller
    debouncer.cancel();

    super.onClose();
  }

  /// Reload data
  Future<void> reload() async {
    /// clear pencarian
    searchController.clear();
    setQueryMenu('');

    /// clear kategori filter
    setCategoryMenu('all');

    /// Fetch data
    await Future.any([
      HomeController.to.getListPromo(),
      HomeController.to.getListMenu(),
    ]);
  }

  /// Promo
  RxString statusPromo = RxString('loading');
  RxString messagePromo = RxString('');
  RxList<PromoData> listPromo = RxList<PromoData>();

  /// Get all promo
  Future<void> getListPromo() async {
    statusPromo.value = 'loading';


    /// Ambil data dari API
    var listPromoRes = await PromoRepo.getAll();

    if (listPromoRes.status_code == 200) {
      /// Jika request API sukses
      statusPromo.value = 'success';
      listPromo.value = listPromoRes.data!;
    } else if (listPromoRes.status_code == 204) {
      /// Jika request API kosong
      statusPromo.value = 'empty';
    } else {
      /// Jika request API gagal, tampilkan pesan error
      statusPromo.value = 'error';
      messagePromo.value = listPromoRes.message ?? 'Unknown error'.tr;
    }
  }

  /// Menu
  RxString categoryMenu = RxString('all');
  RxString queryMenu = RxString('');
  RxString statusMenu = RxString('loading');
  RxString messageMenu = RxString('');
  RxList<MenuData> listMenu = RxList<MenuData>();

  /// Update category filter menu
  Future<void> setCategoryMenu(String value) async {
    categoryMenu.value = value;
  }

  /// Update search filter menu
  Future<void> setQueryMenu(String value) async {
    debouncer.call(() {
      queryMenu.value = value.trim();
    });
  }

  /// Fetch List Menu
  Future<void> getListMenu() async {
    statusMenu.value = 'loading';

    var listMenuRes = await MenuRepository.getAll();

    if (listMenuRes.status_code == 200) {
      statusMenu.value = 'success';
      listMenu.value = listMenuRes.data!;
    } else if (listMenuRes.status_code == 204) {
      statusMenu.value = 'empty';
    } else {
      statusMenu.value = 'error';
      messageMenu.value = listMenuRes.message ?? 'Unknown error'.tr;
    }
  }

  /// Get food list
  List<MenuData> get foodMenu => _getListMenuByFilter(AppConstant.foodCategory);

  /// Get drink list
  List<MenuData> get drinkMenu => _getListMenuByFilter(AppConstant.drinkCategory);

  List<MenuData> _getListMenuByFilter(String category) {
    return listMenu
        .where((e) => e.kategori == category &&
        e.nama.toLowerCase().contains(queryMenu.value.toLowerCase()))
        .toList();
  }
}
