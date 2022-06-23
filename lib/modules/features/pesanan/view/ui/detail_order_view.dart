import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';
import 'package:magang/modules/features/pesanan/controller/detail_ordder_controller.dart';
import 'package:magang/modules/features/pesanan/view/component/check_step.dart';
import 'package:magang/modules/features/pesanan/view/component/detail_order_card.dart';
import 'package:magang/modules/features/pesanan/view/component/uncheck_step.dart';
import 'package:magang/shared/style/shapes.dart';
import 'package:magang/shared/widgets/no_data.dart';
import 'package:magang/shared/widgets/server_error_view.dart';
import 'package:magang/shared/widgets/shimmer.dart';
import 'package:magang/shared/widgets/tiles.dart';
import 'package:magang/utils/extensions/currency_extension.dart';

class DetailOrderView extends StatelessWidget {
  const DetailOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DetailOrderController());

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          splashRadius: 30.r,
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 36.r),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SvgPicture.asset(
              AssetCons.orderIcon,
              width: 23.r,
              color: AppColor.blueColor,
            ),
            10.horizontalSpaceRadius,
            Text('Order'.tr, style: Get.textTheme.titleMedium),
          ],
        ),
        shape: CustomShape.bottomRoundedShape,
        actions: [
          Obx(
                () => Conditional.single(
              context: context,
              conditionBuilder: (context) =>
              DetailOrderController.to.order.value?.status == 0,
              widgetBuilder: (context) => Padding(
                padding: EdgeInsets.symmetric(vertical: 16.r, horizontal: 10.r),
                child: TextButton(
                  onPressed: DetailOrderController.to.cancel,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                  child: Text(
                    'Cancel'.tr,
                    style: Get.textTheme.labelMedium
                        ?.copyWith(color: AppColor.redColor),
                  ),
                ),
              ),
              fallbackBuilder: (context) => const SizedBox(),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: DetailOrderController.to.fetch,
        child: Obx(
              () => ConditionalSwitch.single<String>(
            context: context,
            valueBuilder: (context) => DetailOrderController.to.status.value,
            caseBuilders: {
              'loading': (context) => ListView.separated(
                padding: EdgeInsets.all(25.r),
                separatorBuilder: (_, i) => 18.verticalSpacingRadius,
                itemCount: 3,
                itemBuilder: (_, i) => AspectRatio(
                  aspectRatio: 378 / 89,
                  child: RectShimmer(radius: 10.r),
                ),
              ),
              'empty': (context) => const EmptyDataListView(),
              'error': (context) => const ServerError(),
            },
            fallbackBuilder: (context) => ListView(
              padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 28.r),
              children: [
                /// Food
                if (DetailOrderController.to.foodItems.isNotEmpty) ...[
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetCons.foodIcon,
                        width: 20.r,
                        height: 20.r,
                        color: AppColor.blueColor,
                      ),
                      10.horizontalSpaceRadius,
                      Text(
                        'Food'.tr,
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: AppColor.blueColor),
                      ),
                    ],
                  ),
                  17.verticalSpacingRadius,
                  Wrap(
                    runSpacing: 17.r,
                    children: DetailOrderController.to.foodItems
                        .map<Widget>(
                          (detailOrder) => DetailOrderCard(detailOrder),
                    )
                        .toList(),
                  ),
                  37.verticalSpacingRadius,
                ],

                /// Drink
                if (DetailOrderController.to.drinkItems.isNotEmpty) ...[
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetCons.drinksIcon,
                        width: 20.r,
                        height: 20.r,
                        color: AppColor.blueColor,
                      ),
                      10.horizontalSpaceRadius,
                      Text(
                        'Drink'.tr,
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: AppColor.blueColor),
                      ),
                      25.horizontalSpaceRadius,
                    ],
                  ),
                  17.verticalSpacingRadius,
                  Wrap(
                    runSpacing: 17.r,
                    children: DetailOrderController.to.drinkItems
                        .map<Widget>(
                          (detailOrder) => DetailOrderCard(detailOrder),
                    )
                        .toList(),
                  ),
                  37.verticalSpacingRadius,
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
            () => ConditionalSwitch.single<String>(
          context: context,
          valueBuilder: (context) => DetailOrderController.to.status.value,
          caseBuilders: {
            'loading': (context) => const SizedBox(),
            'empty': (context) => const SizedBox(),
            'error': (context) => const SizedBox(),
          },
          fallbackBuilder: (context) => Container(
            padding: EdgeInsets.all(25.r),
            decoration: BoxDecoration(
              color: AppColor.lightColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Total orders
                Tile(
                  title: 'Total orders'.tr,
                  subtitle:
                  '(${DetailOrderController.to.order.value!.menu.length} Menu):',
                  message:
                  DetailOrderController.to.order.value!.total.toRupiah(),
                  titleStyle: Get.textTheme.headlineSmall,
                  messageStyle: Get.textTheme.labelLarge!
                      .copyWith(color: AppColor.blueColor),
                ),
                Divider(
                    color: AppColor.darkColor2.withOpacity(0.25), height: 2.r),

                /// Discount
                ...Conditional.list(
                  context: context,
                  conditionBuilder: (context) =>
                  DetailOrderController.to.order.value!.diskon == 1 &&
                      DetailOrderController.to.order.value!.potongan > 0,
                  widgetBuilder: (context) => [
                    Tile(
                      icon: AssetCons.discountIcon,
                      iconSize: 24.r,
                      title: 'Discount'.tr,
                      message: DetailOrderController.to.order.value!.potongan
                          .toRupiah(),
                      titleStyle: Get.textTheme.headlineSmall,
                      messageStyle: Get.textTheme.bodySmall!
                          .copyWith(color: AppColor.redColor),
                    ),
                    Divider(
                      color: AppColor.darkColor2.withOpacity(0.25),
                      height: 2.r,
                    ),
                  ],
                  fallbackBuilder: (context) => [],
                ),

                /// Vouchers
                ...Conditional.list(
                  context: context,
                  conditionBuilder: (context) =>
                  DetailOrderController.to.order.value!.id_voucher != 0,
                  widgetBuilder: (context) => [
                    Tile(
                      icon: AssetCons.voucherIcon,
                      iconSize: 24.r,
                      title: 'voucher'.tr,
                      message: DetailOrderController.to.order.value!.potongan
                          .toRupiah(),
                      messageSubtitle:
                      DetailOrderController.to.order.value!.nama_voucher,
                      titleStyle: Get.textTheme.headlineSmall,
                      messageStyle: Get.textTheme.bodySmall!
                          .copyWith(color: AppColor.redColor),
                    ),
                    Divider(
                      color: AppColor.darkColor2.withOpacity(0.25),
                      height: 2.r,
                    ),
                  ],
                  fallbackBuilder: (context) => [],
                ),

                /// Payment options
                Tile(
                  icon: AssetCons.paymentIcon,
                  iconSize: 24.r,
                  title: 'Payment'.tr,
                  message: 'Pay Later',
                  titleStyle: Get.textTheme.headlineSmall,
                  messageStyle: Get.textTheme.bodySmall,
                ),
                Divider(
                    color: AppColor.darkColor2.withOpacity(0.25), height: 2.r),

                /// Total pay
                Tile(
                  iconSize: 24.r,
                  title: 'Total payment'.tr,
                  message: DetailOrderController.to.order.value!.total_bayar
                      .toRupiah(),
                  titleStyle: Get.textTheme.headlineSmall,
                  messageStyle: Get.textTheme.headlineSmall!
                      .copyWith(color: AppColor.blueColor),
                ),
                Divider(
                    color: AppColor.darkColor2.withOpacity(0.25), height: 2.r),
                24.verticalSpacingRadius,

                /// Status order
                Text(
                  'Pesanan kamu sedang disiapkan',
                  style: Get.textTheme.titleSmall,
                  textAlign: TextAlign.left,
                ),
                18.verticalSpacingRadius,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(flex: 10),
                    Expanded(
                      flex: 10,
                      child: Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                        DetailOrderController.to.order.value!.status == 0 ||
                            DetailOrderController.to.order.value!.status == 1,
                        widgetBuilder: (context) => const CheckedStep(),
                        fallbackBuilder: (context) => const UncheckedStep(),
                      ),
                    ),
                    const Spacer(flex: 3),
                    Expanded(
                      flex: 42,
                      child: Container(
                        height: 4.r,
                        color: AppColor.darkColor2.withOpacity(0.25),
                      ),
                    ),
                    const Spacer(flex: 3),
                    Expanded(
                      flex: 10,
                      child: Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                        DetailOrderController.to.order.value!.status == 2,
                        widgetBuilder: (context) => const CheckedStep(),
                        fallbackBuilder: (context) => const UncheckedStep(),
                      ),
                    ),
                    const Spacer(flex: 3),
                    Expanded(
                      flex: 42,
                      child: Container(
                        height: 4.r,
                        color: AppColor.darkColor2.withOpacity(0.25),
                      ),
                    ),
                    const Spacer(flex: 3),
                    Expanded(
                      flex: 10,
                      child: Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                        DetailOrderController.to.order.value!.status == 3,
                        widgetBuilder: (context) => const CheckedStep(),
                        fallbackBuilder: (context) => const UncheckedStep(),
                      ),
                    ),
                    const Spacer(flex: 10),
                  ],
                ),
                11.verticalSpacingRadius,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Order accepted'.tr,
                        style: Get.textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Text(
                        'Please take it'.tr,
                        style: Get.textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Text(
                        'Order completed'.tr,
                        style: Get.textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
