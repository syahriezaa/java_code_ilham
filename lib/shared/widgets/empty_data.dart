import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';

class EmptyDataVertical extends StatelessWidget {
  final double? width;

  const EmptyDataVertical({Key? key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Icon no data
          SvgPicture.asset(
            AssetCons.noDataIcon,
            width: width ?? 250.r,
          ),
          15.verticalSpacingRadius,

          /// Pesan no data
          Text(
            'No data'.tr,
            style: Get.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
