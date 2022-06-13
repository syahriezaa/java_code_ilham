import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/constant/core/apis_const/api_constant.dart';
import 'package:magang/modules/features/dasboard/controller/dasboard_controller.dart';
import 'package:magang/modules/features/keranjang/contrrollers/cart_controller.dart';
import 'package:magang/modules/models/auth_model.dart';
import 'package:magang/modules/models/order_model.dart';
import 'package:magang/utils/services/api_service/login_api.dart';
import 'package:magang/utils/services/local_db_service/local_db_service.dart';

class OrderRepo {
  OrderRepo._();

  static Future<ListOrder> getOnGoing() async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDbService.getToken());
      var user = await LocalDbService.GetUser() as User;
      var response = await dio.get(
          '${ApiConstant.onGoingOrder}/${user.id_user}');

      return ListOrder.fromJson(response.data);
    } on DioError {
      return const ListOrder(status_code: 500);
    }
  }

  static Future<ListOrder> getHistory() async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDbService.getToken());
      var user = await LocalDbService.GetUser() as User;
      var response = await dio.post(
          '${ApiConstant.historyOrder}/${user.id_user}');
      if (response.data['status_code'] == 200) {
        response.data['data'] = response.data['data']['listData'];
      }

      return ListOrder.fromJson(response.data);
    } on DioError {
      return const ListOrder(status_code: 500);
    }
  }

  static Future<OrderRes> getFromId(int id) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDbService.getToken());
      var response = await dio.get('${ApiConstant.detailOrder}/$id');

      return OrderRes.fromJson(response.data);
    } on DioError {
      return const OrderRes(status_code: 500);
    }
  }

}