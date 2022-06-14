import 'dart:async';

import 'package:get/get.dart';
import 'package:magang/modules/features/keranjang/repositories/order_repo.dart';
import 'package:magang/modules/features/pesanan/repositories/order_repo.dart';
import 'package:magang/modules/models/detail_order.dart';
import 'package:magang/modules/models/order_model.dart';

class DetailOrderController extends GetxController {
  static DetailOrderController get to => Get.find();

  /// Data pesanan
  RxString status = RxString('loading');
  Rxn<Order> order = Rxn();
  Timer? timer;

  @override
  void onInit() {
    super.onInit();

    /// Ambil data pesanan, dan jika berhasil, ambil data detail pesanan
    /// Atur timer untuk mengambil data detail pesanan secara berkala
    fetch().then((_) {
      timer = Timer.periodic(const Duration(seconds: 10), (_) => fetch());
    });
  }

  @override
  void onClose() {
    super.onClose();

    /// Hentikan timer
    timer?.cancel();
  }

  /// Ambil data pesanan
  Future<void> fetch() async {
    if (order.value != null) {
      status.value = 'update';
      await fetchOrderFromId(order.value!.id_order);
    } else if (Get.arguments is int) {
      status.value = 'loading';
      await fetchOrderFromId(Get.arguments as int);
    } else if (Get.arguments is Order) {
      order.value = Get.arguments as Order;
      status.value = 'update';
      await fetchOrderFromId(order.value!.id_order);
    }
  }

  /// Ambil data pesanan dari id pesanan
  Future<void> fetchOrderFromId(int id) async {
    OrderRes orderRes = await OrderRepo.getFromId(id);

    if (orderRes.status_code == 200) {
      status.value = 'success';
      order.value = null;
      order.value = orderRes.data;
    } else if (orderRes.status_code == 204) {
      status.value = 'empty';
    } else {
      status.value = 'error';
    }
  }

  /// Getter for food items
  List<OrderDetail> get foodItems => order.value != null
      ? order.value!.menu.where((e) => e.isFood).toList()
      : [];

  /// Getter for drink items
  List<OrderDetail> get drinkItems => order.value != null
      ? order.value!.menu.where((e) => e.isDrink).toList()
      : [];
}
