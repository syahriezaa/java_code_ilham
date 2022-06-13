import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';


class OrderDataEmpty extends StatelessWidget {
  final String title;
  final String? subtitle;

  const OrderDataEmpty({
    Key? key,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetCons.background),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Stack(
        children: [
          ListView(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetCons.noteIcon,
                  width: 150.r,
                ),
                25.verticalSpacingRadius,
                Text(
                  title,
                  style: Get.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                ...Conditional.list(
                  context: context,
                  conditionBuilder: (context) => subtitle != null,
                  widgetBuilder: (context) => [
                    10.verticalSpacingRadius,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.r),
                      child: Text(
                        subtitle!,
                        style: Get.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  fallbackBuilder: (context) => [],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
