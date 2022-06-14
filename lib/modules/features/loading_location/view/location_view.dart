import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';
import 'package:magang/modules/features/dasboard/controller/dasboard_controller.dart';
import 'package:magang/modules/features/loading_location/controller/location_controller.dart';

class LoadingLocation extends GetView<LocationController> {
  const LoadingLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetCons.background),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Searching location...'.tr,
                style: Get.textTheme.titleLarge!.copyWith(
                  color: AppColor.darkColor.withOpacity(0.5),
                ),
                textAlign: TextAlign.center,
              ),
              50.verticalSpacingRadius,
              Stack(
                children: [
                  Image.asset(AssetCons.locationIcon, width: 190.r),
                  Padding(
                    padding: EdgeInsets.all(70.r),
                    child: Icon(Icons.location_pin, size: 50.r),
                  ),
                ],
              ),
              50.verticalSpacingRadius,
              Obx(
                    () => ConditionalSwitch.single<String>(
                  context: context,
                  valueBuilder: (context) =>
                  DashboardController.to.statusLocation.value,
                  caseBuilders: {
                    'error': (context) => Text(
                      DashboardController.to.messageLocation.value,
                      style: Get.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    'success': (context) => Text(
                      DashboardController.to.address.value!,
                      style: Get.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  },
                  fallbackBuilder: (context) =>
                  const CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
