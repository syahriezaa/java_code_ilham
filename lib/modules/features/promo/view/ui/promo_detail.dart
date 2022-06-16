import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';
import 'package:magang/utils/extensions/string_case_extension.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../config/themes/colors.dart';
import '../../../../../shared/widgets/shimmer.dart';
import '../../../dasboard/view/component/promo_card.dart';
import '../../controller/promo_by_id_controller.dart';

class PromoDetailView extends StatelessWidget {
  const PromoDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PromoByIdController());
    print(PromoByIdController.to.status.value);


    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.chevron_left,color:Colors.black,size:32.w),
          onPressed:()=> Get.back(),
        ),
        centerTitle: true,
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SvgPicture.asset(AssetCons.promoIcon,width:32.w),
            SizedBox(width:10.w),
            Text("Promo".tr,
              style:
              Theme.of(context)
                .textTheme
                .titleMedium
            ),
          ],
        ),
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
            bottom:Radius.circular(30.w),
        ),
      ),
      ),
      backgroundColor: lightColor,
      body:Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25.w),
            child: Obx(
                  () => Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                PromoByIdController.to.status.value == 'success',
                widgetBuilder: (context) => Screenshot(
                  controller: PromoByIdController.to.screenshotController,
                  child: PromoCard(
                    promo: PromoByIdController.to.promo.value!,
                    width: 378.w,
                    height: 181.h,
                    shadow: true,
                  ),
                ),
                fallbackBuilder: (context) => RectShimmer(
                  width: 378.w,
                  height: 181.h,
                  radius: 15.w,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.w)),
              ),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 45.h),
                children: [
                  Obx(
                        () => Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                      PromoByIdController.to.status.value == 'success',
                      widgetBuilder: (context) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              PromoByIdController.to.promo.value!.nama
                                  .toTitleCase(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          SizedBox(width: 25.w),
                          Text(
                            PromoByIdController
                                .to.promo.value!.typeAmountLabel,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: blueColor),
                          ),
                        ],
                      ),
                      fallbackBuilder: (context) => RectShimmer(height: 25.h),
                    ),
                  ),
                  SizedBox(height: 17.h),
                  Divider(color: const Color(0xFF2E2E2E).withOpacity(0.25)),
                  SizedBox(height: 13.h),
                  Row(
                    children: [
                      const Icon(Icons.list, color: blueColor),
                      SizedBox(width: 14.w),
                      Text(
                        'Terms and Conditions'.tr,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Obx(
                        () => Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                      PromoByIdController.to.status.value == 'success',
                      widgetBuilder: (context) => Html(
                        data: PromoByIdController
                            .to.promo.value!.syarat_ketentuan,
                        style: {
                          '*': Style.fromTextStyle(
                            Theme.of(context).textTheme.labelMedium!,
                          ),
                          'body': Style(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                          ),
                        },
                      ),
                      fallbackBuilder: (context) => RectShimmer(height: 100.h),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]
      ),
        floatingActionButton: FloatingActionButton(
        backgroundColor: blueColor,
    foregroundColor: Colors.white,
    child: const Icon(Icons.share),
    onPressed: () => PromoByIdController.to.sharePromo(),
        )
    );
  }
}
