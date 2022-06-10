import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';


class Finggerprint extends StatelessWidget {
  const Finggerprint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 15.w),
    child: Column(
      children: [
        Text(
          'Verivy order'.tr,
          style: Theme.of(context)
              .textTheme
              .headlineMedium,
        ),
        Text("Press your finggerprint",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(
                color: greyColor
            )
        ),
      SizedBox(height: 30.h),
      GestureDetector(
        child: SvgPicture.asset(AssetCons.finggerIcon),
        onTap: ()=>Get.back<String>(result: 'finnggerprint'),
      ),
        SizedBox(height: 30.h),
        Row(
          children: [
            Expanded(child: Divider(color: Colors.black.withOpacity(0.25))),
            SizedBox(width: 15.w),
            Text(
              "or".tr,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: darkColor.withOpacity(0.25),
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(child: Divider(color: Colors.black.withOpacity(0.25))),
            TextButton(
              onPressed: () => Get.back<String>(result: 'pin'),
              child: Text(
                'Verify using PIN code'.tr,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: blueColor),
              )
              ),
          ],

        ),

      ],
    ),
    );
  }
}
