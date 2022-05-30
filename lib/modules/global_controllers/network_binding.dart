import 'package:get/get.dart';
import 'package:magang/modules/global_controllers/global_conection.dart';

class NetworkBinding extends Bindings{


  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<GlobalConection>(() =>GlobalConection(),tag: "network_status");
  }

}