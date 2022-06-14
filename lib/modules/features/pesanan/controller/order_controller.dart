import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/modules/features/dasboard/controller/dasboard_controller.dart';
import 'package:magang/modules/features/keranjang/contrrollers/cart_controller.dart';
import 'package:magang/modules/features/pesanan/repositories/order_repo.dart';
import 'package:magang/modules/models/keranjang.dart';
import 'package:magang/modules/models/order_model.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


class OrderController extends GetxController {
  static OrderController get to => Get.find();

  void onInit(){
    super.onInit();
    fetchOnGoing();
    fetchHistory();
    initializeDateFormatting();
  }

  ///variables
  ///varible data pesanan yang sedang berjalan
  RxString onGoingStatus = RxString('loading');
  RxList<Order> onGoingOrders = RxList<Order>();

  ///data Riwayat pesanan
  RxString historyStatus = RxString('loading');
  RxList<Order> historyOrders = RxList<Order>();
  String selectedCategory = 'all';

  ///Fect data

  ///Mengambil data pesanan yang sedang berjalan

  Future<void> fetchOnGoing() async {
    onGoingStatus.value = 'loading';

    print('fetching on going');

    ///call from repo data yang sedang berjalan
    ListOrder listOrder= await OrderRepo.getOnGoing();
    if (listOrder.status_code == 200) {
      ///jika berhasil, tampilkan data
      onGoingStatus.value = 'success';
      onGoingOrders.value = listOrder.data!;
      print(listOrder.data);
    } else if (listOrder.status_code == 204) {
      onGoingStatus.value = 'empty';
    } else {
      onGoingStatus.value = 'error';
    }
  }
  ///data filter riwayat pesanan
  DateTimeRange selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 7)),
    end: DateTime.now(),
  );
  ///Set filter riwayat pesanan
  void setFilter({String? category, DateTimeRange? dateRange}) {
    selectedCategory = category ?? 'all';
    selectedDateRange = dateRange ?? selectedDateRange;
    historyOrders.refresh();
  }
  ///filter riwayat pesanan
  List<Order> get historyOrderFiltered {
    List<Order> list = historyOrders.toList();

    /// Filter category
    if (selectedCategory == 'canceled') {
      list.removeWhere((e) => e.status != 4);
    } else if (selectedCategory == 'completed') {
      list.removeWhere((e) => e.status != 3);
    }

    /// Filter date
    list.removeWhere((e) =>
    e.tanggal.isBefore(selectedDateRange.start) ||
        e.tanggal.isAfter(selectedDateRange.end));

    /// Sort based on date
    list.sort((a, b) => b.tanggal.compareTo(a.tanggal));

    return list;
  }

  /// Ambil data riwayat pesanan
  Future<void> fetchHistory() async {
    historyStatus.value = 'loading';

    /// Fetch data riwayat pesanan
    ListOrder listOrderRes = await OrderRepo.getHistory();

    if (listOrderRes.status_code == 200) {
      /// Jika berhasil, tampilkan data
      historyStatus.value = 'success';
      historyOrders.value = listOrderRes.data!;
    } else if (listOrderRes.status_code == 204) {
      historyStatus.value = 'empty';
    } else {
      historyStatus.value = 'error';
    }
  }

  /// Memesan menu lagi
  void onOrderAgain(Order order) {
    for (var detail in order.menu) {
      /// Apakah data menu masih ada
      var menu = DashboardController.to.listMenu
          .firstWhereOrNull((e) => e.id_menu == detail.id_menu);

      if (menu != null) {
        /// Jika menu ada, tambahkan ke cart
        PesananController.to.add(Keranjang(
          menu: menu,
          quantity: detail.jumlah,
          note: '',
          level: null,
          toppings: null,
        ));
      }
    }

    /// Kembali ke halaman keranjang
    Get.toNamed(AppRoutes.keranjangView);
  }

}