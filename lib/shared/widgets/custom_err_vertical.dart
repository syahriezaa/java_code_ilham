import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';


class CustomErrorVertical extends StatelessWidget {
  final String message;

  const CustomErrorVertical({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
          15.verticalSpacingRadius,

          /// Pesan error
          Text(
            message,
            style: Get.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
