import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:get/get.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/modules/features/dasboard/controller/dasboard_controller.dart';
import 'package:magang/modules/features/keranjang/repositories/diskon_repo.dart';
import 'package:magang/modules/features/keranjang/repositories/order_repo.dart';
import 'package:magang/modules/features/keranjang/repositories/voucher_repo.dart';
import 'package:magang/modules/features/keranjang/view/components/discount_detail.dart';
import 'package:magang/modules/features/keranjang/view/components/order_succes.dart';
import 'package:magang/modules/features/keranjang/view/components/pin_dialogue.dart';
import 'package:magang/modules/models/auth_model.dart';
import 'package:magang/modules/models/keranjang.dart';
import 'package:magang/modules/models/voucher_model.dart';
import 'package:magang/shared/widgets/ErrorSnackBar.dart';
import 'package:magang/utils/services/local_db_service/local_db_service.dart';

import '../../../models/discount_model.dart';
import '../view/components/finggerprint.dart';

class PesananController extends GetxController {
  static PesananController get to => Get.find();

  @override
  void onInit() {
    super.onInit();

    getDiscounts();
    getVouchers();
  }


  /// variables
  Rxn<VoucherData> selectedVoucher = Rxn<VoucherData>();
  RxList<VoucherData> vouchers = RxList<VoucherData>();

  RxList<Diskon> discounts = RxList<Diskon>();
  RxString voucherStatus = RxString('loading');


  RxList<Keranjang> keranjang = RxList<Keranjang>();


  /// Getter
  ///Get Diskon
  Future <void> getDiscounts() async {
    var diskonResponse = await DiskonRepo.getAll();

    if (diskonResponse.status_code == 200) {
      diskonResponse.data!.shuffle();
      discounts.value = diskonResponse.data!.sublist(0, 2);
    }
  }

  ///food items
  List<Keranjang> get foodItems => keranjang.where((e) => e.isFood).toList();

  ///drink items
  List<Keranjang> get drinkItems => keranjang.where((e) => e.isDrink).toList();

  ///total price
  int get totalPrice => keranjang.fold(0, (total, item) => total + item.totalPrice);

  /// Get discount for user
  Future<void> getVouchers() async {
    voucherStatus.value = 'loading';
    var listVoucherList = await VoucherRepo.getAll();

    if (listVoucherList.status_code == 200) {
      voucherStatus.value = 'success';
      vouchers.value = listVoucherList.data!;
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
  void add(Keranjang keranjanglogic) {
    keranjang.remove(keranjanglogic);
    keranjang.add(keranjanglogic);
  }

  /// hapus Keranjang
  void remove(Keranjang keranjangLogic) {
    keranjang.remove(keranjangLogic);
  }

  /// Penambahan jumlah
  void increment(Keranjang keranjanglogic) {
    keranjanglogic.quantity++;
    keranjang.refresh();
  }

  ///Pengurangan jumlah
  void decrement(Keranjang keranjanglogic) {
    if (keranjanglogic.quantity > 1) {
      keranjanglogic.quantity--;
      keranjang.refresh();
    } else {
      keranjang.remove(keranjanglogic);
    }
  }

  /// Update note
  void updateNote(Keranjang keranjanglogic, String note) {
    keranjanglogic.note = note;
  }

  /// Set voucher
  void setVoucher(VoucherData? voucher) {
    selectedVoucher.value = voucher;
  }

  /// Order
  void order() async {
    final LocalAuthentication auth = LocalAuthentication();
    final bool isBiometricSupported = await auth.isDeviceSupported();
    final bool canCheck = await auth.canCheckBiometrics;


/// jika biometrik bisa di gunakan
    if (isBiometricSupported && canCheck) {
      try {
        ///buka popup finggerprint
        final staus = await openFingerprintDialog();
        if ( staus == 'finggerprint') {
          final bool didAuth = await auth.authenticate(
              localizedReason: 'Please authenticate to confirm order'.tr,
              options: const AuthenticationOptions(
                biometricOnly: true,
              )
          );
          if (didAuth) {
            orderNow();
          }
        }else if(staus == 'pin'){
          pinDialog();
        }
      } on PlatformException catch (e) {
        print(e);
            await pinDialog();
      }
    }else{
      await pinDialog();
    }
  }


  ///page routing
  ///
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

  /// open Finggerprint dialog
  Future<String?> openFingerprintDialog() async {
    Get.until(ModalRoute.withName(AppRoutes.keranjangView));
    final arguments = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const Finggerprint(),
    );
    return arguments;
  }
/// order now
  void orderNow() async{
    ///tutup dialog
    Get.until(ModalRoute.withName(AppRoutes.keranjangView));
    Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const OrderSucces(),
    );

    final cartReq = CartRequest(
      user: await LocalDbService.GetUser() as User,
      cart: keranjang,
      discounts: discounts.isEmpty ? null : discounts.toList(),
      voucher: selectedVoucher.value,
      discountPrice: totalPrice - grandTotalPrice,
      totalPrice: grandTotalPrice,
    );
    print("cartReq: " + cartReq.cart.toString());
    final response = await OrderRepository.add(cartReq);

    if (response != null &&
        response.statusCode == 200 &&
        response.data['status_code'] == 200) {
      print("sukses");
      /// Jika sukses, buka dialog sukses
      openOrderSuccessDialog(response.data['data']['id_order']);
      print("data: "+response.data['data'].toString());
    } else {
      /// Jika gagal, buka dialog error
      Get.until(ModalRoute.withName(AppRoutes.keranjangView));
      Get.showSnackbar(ErrorSnackBar(
        title: 'Error'.tr,
        message: 'Server error'.tr,
      ));
    }
  }

  void openOrderSuccessDialog(int id) async {
    Get.until(ModalRoute.withName(AppRoutes.keranjangView));
    await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const OrderSucces(),
    );

    /// Atur dasbor ke halaman order
    DashboardController.to.tabIndex.value = 1;

    /// Navigasi ke halaman order
    Get.until(ModalRoute.withName(AppRoutes.DashboardView));

    /// Hapus data keranjang
    keranjang.clear();
    selectedVoucher.value = null;
  }


  Future <void> pinDialog()async{
    Get.until(ModalRoute.withName(AppRoutes.keranjangView));

    int tries = 0;
    final User user = await LocalDbService.GetUser() as User;

    await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: PinDialog(
        onCheckPin: (String? pin) {
          if (pin == user.pin) {
            orderNow();
            return null;
          } else {
            tries++;
            if (tries >= 3) {
              Get.until(ModalRoute.withName(AppRoutes.keranjangView));
              Get.showSnackbar(GetSnackBar(
                title: 'Error'.tr,
                message:
                'PIN already wrong 3 times. Please try again later.'.tr,
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ));
              return null;
            } else {
              return 'PIN wrong! n chances left.'.trParams({
                'n': (3 - tries).toString(),
              });
            }
          }
        },
      ),
    );
  }

}
