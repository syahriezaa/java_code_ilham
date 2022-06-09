import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/modules/features/pesanan/repositories/diskon_repo.dart';
import 'package:magang/modules/features/pesanan/repositories/voucher_repo.dart';
import 'package:magang/modules/features/pesanan/view/components/discount_detail.dart';
import 'package:magang/modules/models/detail_order.dart';
import 'package:magang/modules/models/voucher_model.dart';

import '../../../models/discount_model.dart';

class PesananController extends GetxController {
  static PesananController get to => Get.find();

  @override
  void onInit() {
    super.onInit();

    getDiscounts();
  }


  /// variables
  Rxn<VoucherData> selectedVoucher = Rxn<VoucherData>();
  RxList<VoucherData> vouchers = RxList<VoucherData>();

  RxList<Diskon> discounts = RxList<Diskon>();
  RxString voucherStatus = RxString('loading');


  RxList<DetailOrder> cart = RxList<DetailOrder>();
/// Getter
  ///Get Diskon
  Future <void> getDiscounts() async {
    var diskonResponse = await DiskonRepo.getAll();

    if (diskonResponse.status_code == 200) {
      diskonResponse.data!.shuffle();
      // TODO: Update this code
      discounts.value = diskonResponse.data!.sublist(0, 2); diskonResponse.data!.shuffle();
    }
  }
  ///food items
  List<DetailOrder> get foodItems => cart.where((e) => e.isFood).toList();

  ///drink items
  List<DetailOrder> get drinkItems => cart.where((e) =>e.isDrink).toList();

  ///total price
  int get totalPrice => cart.fold(0, (total, item) => total + item.totalPrice);

  /// Get discount for user
  Future<void> getVouchers() async {
    voucherStatus.value = 'loading';
    var listVoucherList = await VoucherRepo.getAll();

    if (listVoucherList.status_code == 200) {
      voucherStatus.value = 'success';
      vouchers.value = listVoucherList.data!;
      print('vouchers: ${vouchers.value}');
    } else {
      voucherStatus.value = 'error';
    }
  }

  ///discount price
  int get discountPrice {
    if (selectedVoucher.value == null) {
      return totalPrice * totalDiscount ~/ 100;
    } else {
      return 0;
    }
  }
  ///total discount
  int get totalDiscount =>
      discounts.fold(0, (total, discount) => total + discount.nominal);

  /// get cvoucher price
  int get voucherPrice => selectedVoucher.value!.nominal;

  /// get total price with voucher and discount
  int get grandTotalPrice {
    if (selectedVoucher.value != null) {
      return max(totalPrice - voucherPrice, 0);
    } else {
      return max(totalPrice - discountPrice, 0);
    }
  }


  ///Utilities
  ///
  ///
  ///tambah keranjang
  void add(DetailOrder orderDetail) {
    cart.remove(orderDetail);
    cart.add(orderDetail);
  }

  /// hapus Keranjang
  void remove(DetailOrder orderDetail) {
    cart.remove(orderDetail);
  }
 /// Penambahan jumlah
  void increment(DetailOrder orderDetail) {
    orderDetail.quantity++;
    cart.refresh();
  }
  ///Pengurangan jumlah
  void decrement(DetailOrder orderDetail) {
    if (orderDetail.quantity > 1) {
      orderDetail.quantity--;
      cart.refresh();
    } else {
      cart.remove(orderDetail);
    }
  }

  /// Update note
  void updateNote(DetailOrder orderDetail, String note) {
    orderDetail.note = note;
  }
  /// Set voucher
  void setVoucher(VoucherData? voucher) {
    selectedVoucher.value = voucher;
  }




  ///page routing

///open dialog for discount
  void openDiscountDialog() {
    Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: DiskonDetailView(discounts: discounts),
    );
  }
///open dialog for voucher
  void openVoucherDialog() {
    if (vouchers.isEmpty) getVouchers();
    Get.toNamed(AppRoutes.ChooseVoucherView);
  }


}
