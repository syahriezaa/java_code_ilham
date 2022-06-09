import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:magang/constant/core/apis_const/api_constant.dart';
import 'package:magang/modules/models/voucher_model.dart';
import 'package:magang/utils/services/api_service/login_api.dart';
import 'package:magang/utils/services/local_db_service/local_db_service.dart';

class VoucherRepo{
  VoucherRepo._();

  static Future<VoucherResponse> getAll()async{
    try {
      var dio = ApiServices.dioCall(token: await LocalDbService.getToken());
      var response = await dio.get(ApiConstant.allVoucher);

      return VoucherResponse.fromJson(response.data);
    } on DioError {
      return VoucherResponse(status_code: 500, message: "Server error");
    }
  }
}