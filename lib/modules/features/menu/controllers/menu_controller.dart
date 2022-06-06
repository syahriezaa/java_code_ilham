import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang/modules/features/menu/repositories/menu_repo.dart';
import 'package:magang/modules/models/menu_model.dart';

class MenuController extends GetxController {
  static MenuController get to => Get.find();

  RxString status = RxString('loading');
  RxBool isInCart = RxBool(false);

  Rxn<MenuData> menu = Rxn<MenuData>();

  RxList<MenuVariant> level = RxList<MenuVariant>();
  RxList<MenuVariant> topping = RxList<MenuVariant>();

  RxInt quantity = RxInt(1);
  Rxn<MenuVariant>selectedLevel= Rxn<MenuVariant>();
  Rxn<MenuVariant>selectedTopping= Rxn<MenuVariant>();
  RxString note = RxString('');

  @override
  void onInit() {
    super.onInit();
    menu.value =Get.arguments as MenuData;

    MenuRepo.getMenuById(menu.value!.id_menu).then((menuRes) {
      if(menuRes.status_code==200){
        status.value = 'success';
        level.value = menuRes.level;
        topping.value = menuRes.topping;
      }
      if(level.isNotEmpty){
        selectedLevel.value = level.value.first;
      }
      else{
        status.value = 'error';
      }
    });
  }
  void onIncrement() {
    quantity.value++;
  }
  void onDecrement() {
    quantity.value--;
  }
  void OpenNote(){

  }
}