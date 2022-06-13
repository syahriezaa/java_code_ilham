import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';


class ServerError extends StatelessWidget {
  const ServerError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Listview
        ListView(),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Icon server error
              SvgPicture.asset(
                AssetCons.serverError,
                width: 250.r,
              ),
              25.verticalSpacingRadius,

              /// Teks server error
              Text(
                'Server error'.tr,
                style: Get.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
