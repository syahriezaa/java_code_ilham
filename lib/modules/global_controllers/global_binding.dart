import 'package:get/get.dart';
import 'package:magang/modules/global_controllers/global_conection.dart';

class GlobalBinding extends Bindings{


  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<NewworkController>(NewworkController(),permanent:true,tag:"GlobalBinding");
  }

}