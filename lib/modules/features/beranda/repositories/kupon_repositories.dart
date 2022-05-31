import 'package:dio/dio.dart';
import 'package:magang/modules/models/auth_model.dart';
import 'package:magang/modules/models/promo_model.dart';

import '../../../../constant/core/apis_const/api_constant.dart';
import '../../../../utils/services/api_service/login_api.dart';

class KuponResponse{
  Future<KuponResponse> kupon(String token) async {
    try {
      var response = await ApiServices.dioCall.get(
          ApiConstant.url + "promo/all", );
      return PromoData.fromJson(response.data);
    }
    on DioError {
      return PromoResponse(status_code: 500);
    }
  }

}
