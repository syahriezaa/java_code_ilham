import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/modules/features/keranjang/contrrollers/cart_controller.dart';
import 'package:magang/modules/features/menu/repositories/menu_repo.dart';
import 'package:magang/modules/features/menu/view/components/LevelBottomSheet.dart';
import 'package:magang/modules/features/menu/view/components/note_bottom_sheet.dart';
import 'package:magang/modules/features/menu/view/components/topping_bottom_sheet.dart';
import 'package:magang/modules/models/keranjang.dart';
import 'package:magang/modules/models/menu_model.dart';
import 'package:magang/shared/style/shapes.dart';

import '../../keranjang/contrrollers/cart_controller.dart';

class MenuController extends GetxController {
  static MenuController get to => Get.find();

  RxString status = RxString('loading');
  RxString statusLevels = RxString('loading');
  RxString statusToppings = RxString('loading');
  RxBool isInCart = RxBool(false);

  Rxn<MenuData> menu = Rxn<MenuData>();
  RxList<MenuVariant> levels = RxList<MenuVariant>([]);
  RxList<MenuVariant> topping = RxList<MenuVariant>([]);

  RxInt quantity = RxInt(1);
  Rxn<MenuVariant>selectedLevel= Rxn<MenuVariant>();
  RxList<MenuVariant>selectedTopping= RxList<MenuVariant>();
  RxString note = RxString('');


  @override
  void onInit() {
    super.onInit();
    menu.value =Get.arguments as MenuData;
    print(isInCart.value);
    updateDataFromCart();
    MenuRepo.getMenuById(menu.value!.id_menu).then((menuRes) {
      if (menuRes.status_code == 200) {
        status.value = 'success';

        if (menuRes.level.isNotEmpty) {
          statusLevels.value = 'success';
          levels.value = menuRes.level;

          /// Atur level ke default
          selectedLevel.value ??= levels.first;
        } else {
          statusLevels.value = 'empty';
        }

        if (menuRes.topping.isNotEmpty) {
          statusToppings.value = 'success';
          topping.value = menuRes.topping;
        } else {
          statusToppings.value = 'empty';
        }
      } else {
        status.value = 'error';
        statusLevels.value = 'error';
        statusToppings.value = 'error';
      }
    });


  }

  void updateDataFromCart() {
    final cartOrderDetail =
    PesananController.to.keranjang
        .firstWhereOrNull((e) => e.menu.id_menu == menu.value?.id_menu);
try{
    if (cartOrderDetail != null) {
      isInCart.value = true;
      selectedLevel.value = cartOrderDetail.level;
      note.value = cartOrderDetail.note;
      selectedTopping.value = cartOrderDetail.toppings?.toList() ?? [];
      quantity.value = cartOrderDetail.quantity;
    }}catch(e){
      print(e);
    }
  }

  void onIncrement() {
    quantity.value++;
  }
  void onDecrement() {
    quantity.value--;
  }



  /// Pemilihan Toping
  void toggleTopping(MenuVariant topping) {
    if (selectedTopping.contains(topping)) {
      selectedTopping.remove(topping);
    } else {
      selectedTopping.add(topping);
    }
    selectedTopping.sort((a, b) => a.keterangan.compareTo(b.keterangan));
  }

  String get selectedToppingsText => selectedTopping.isNotEmpty
      ? selectedTopping.map((topping) => topping.keterangan).join(', ')
      : 'Choose topping'.tr;

  Keranjang get keranjang => Keranjang(
      menu: menu.value!,
      quantity: quantity.value,
      note: note.value,
      level: selectedLevel.value,
      toppings: topping.isEmpty ? null : selectedTopping.toList());

///Level Bottom sheet
  void openLevelBottomSheet() {
    Get.bottomSheet(
      const LevelBottomSheet(),
      backgroundColor: Colors.white,
      shape: CustomShape.topRoundedShape,
      isScrollControlled: true,
    );
  }

  /// Set level
  void setLevel(MenuVariant level) {
    selectedLevel.value = level;
    if (Get.isBottomSheetOpen == true) Get.back();
  }

  /// Getter for selected level text
  String get selectedLevelText => selectedLevel.value?.keterangan ?? '-';

  /// topping bottom sheet
  void openToppingBottomSheet() {
    Get.bottomSheet(
      const ToppingBottomSheet(),
      backgroundColor: Colors.white,
      shape: CustomShape.topRoundedShape,
      isScrollControlled: true,
    );
  }


  /// Note bottom sheet
  void openNoteBottomSheet() {
    Get.bottomSheet(
      NoteBottomSheet(),
      backgroundColor: Colors.white,
      shape: CustomShape.topRoundedShape,
      isScrollControlled: true,
    );
  }

  /// Set note
  void setNote(String note) {
    this.note.value = note.trim();
    if (Get.isBottomSheetOpen == true) Get.back();
  }

  ///tambah Keranjang

  void addToCart() {
    if (status.value == 'success' &&
        (selectedLevel.value != null || levels.isEmpty)) {
      isInCart.value = true;
      PesananController.to.add(keranjang);
      Get.offNamedUntil(
        AppRoutes.keranjangView,
        ModalRoute.withName(AppRoutes.DashboardView),
      );
    }
  }
  void deleteFromCart() {
    PesananController.to.remove(keranjang);
    Get.offNamedUntil(
      AppRoutes.keranjangView,
      ModalRoute.withName(AppRoutes.DashboardView),
    );
  }

}