import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:magang/modules/models/detail_order.dart';

class CartController extends GetxController{
  static CartController get to => Get.find();
  RxList<DetailOrder> cart = RxList<DetailOrder>();

  ///tambah keranjang
  void add(DetailOrder orderDetail) {
    cart.remove(orderDetail);
    cart.add(orderDetail);
  }
/// hapus Keranjang
  void remove(DetailOrder orderDetail) {
    cart.remove(orderDetail);
  }
}
