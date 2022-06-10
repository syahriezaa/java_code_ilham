import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';
import 'package:magang/shared/widgets/primary_button.dart';

class OrderSucces extends StatelessWidget {
  const OrderSucces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 28.h),
          SvgPicture.asset(AssetCons.successIcon),
          SizedBox(height: 28.h),
          Text(
            'Order is being prepared'.tr,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 14.h),
          Text(
            'You can track your order in order history'.tr,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: greyColor),
          ),
          SizedBox(height: 14.h),
          SizedBox(
            width: 168.w,
            child: PrimaryButton(
              onPressed: () => Get.back(),
              text: 'Okay'.tr,
            ),
          ),
        ],
      ),
    );
  }
}
