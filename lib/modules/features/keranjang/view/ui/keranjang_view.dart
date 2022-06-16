import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';
import 'package:magang/modules/features/dasboard/view/component/MenuCard.dart';
import 'package:magang/modules/features/keranjang/contrrollers/cart_controller.dart';
import 'package:magang/shared/widgets/primary_button.dart';
import 'package:magang/shared/widgets/tiles.dart';
import 'package:magang/utils/extensions/currency_extension.dart';

class KeranjangView extends StatelessWidget {
  const KeranjangView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 32.w),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SvgPicture.asset(AssetCons.pesanan, width: 23.w),
            SizedBox(width: 10.w),
            Text(
              'Pesanan'.tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.w),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()=> Future.any([
          PesananController.to.getDiscounts(),
        ]),
        child: Obx(
            ()=>Conditional.single(
              context: context,
              conditionBuilder: (context) => PesananController.to.keranjang.isEmpty,
              widgetBuilder: (context) => SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetCons.EmptycartIcon,
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                    Text(
                      'Empty cart'.tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              fallbackBuilder: (context) => ListView(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 28.h),
                children: [
                  /// Food
                  ...Conditional.list(
                    context: context,
                    conditionBuilder: (context) =>
                    PesananController.to.foodItems.isEmpty,
                    widgetBuilder: (context) => const [],
                    fallbackBuilder: (context) => [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AssetCons.foodIcon,
                            width: 20.r,
                            height: 20.r,
                            color: blueColor,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'Food'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: blueColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 17.h),
                      Wrap(
                        runSpacing: 17.h,
                        children: PesananController.to.foodItems
                            .map<Widget>(
                              (orderDetail) => MenuCard(
                            menu: orderDetail.menu,
                            price: orderDetail.price,
                            quantity: orderDetail.quantity,
                            note: orderDetail.note,
                            onIncrement: () =>
                                PesananController.to.increment(orderDetail),
                            onDecrement: () =>
                                PesananController.to.decrement(orderDetail),
                            onNoteChanged: (value) => PesananController.to
                                .updateNote(orderDetail, value),
                            onTap: () => Get.toNamed(
                              AppRoutes.MenuDetailView,
                              arguments: orderDetail.menu,
                            ),
                          ),
                        )
                            .toList(),
                      ),
                      SizedBox(height: 37.h),
                    ],
                  ),

                  /// Drink
                  ...Conditional.list(
                    context: context,
                    conditionBuilder: (context) =>
                    PesananController.to.drinkItems.isEmpty,
                    widgetBuilder: (context) => const [],
                    fallbackBuilder: (context) => [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AssetCons.drinksIcon,
                            width: 20.r,
                            height: 20.r,
                            color: blueColor,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'Drink'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: blueColor),
                          ),
                          SizedBox(width: 25.w),
                        ],
                      ),
                      SizedBox(height: 17.h),
                      Wrap(
                        runSpacing: 17.h,
                        children: PesananController.to.drinkItems
                            .map<Widget>(
                              (orderDetail) => MenuCard(
                            menu: orderDetail.menu,
                            price: orderDetail.price,
                            quantity: orderDetail.quantity,
                            note: orderDetail.note,
                            onIncrement: () =>
                                PesananController.to.increment(orderDetail),
                            onDecrement: () =>
                                PesananController.to.decrement(orderDetail),
                            onNoteChanged: (value) => PesananController.to
                                .updateNote(orderDetail, value),
                            onTap: () => Get.toNamed(
                              AppRoutes.MenuDetailView,
                              arguments: orderDetail.menu,
                            ),
                          ),
                        )
                            .toList(),
                      ),
                      SizedBox(height: 37.h),
                    ],
                  ),
                ],
              ),
            ),
        ),
      ),
      bottomNavigationBar: Obx(
            () => Conditional.single(
          context: context,
          conditionBuilder: (context) => PesananController.to.keranjang.isEmpty,
          widgetBuilder: (context) => const SizedBox(),
          fallbackBuilder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 22.w),
                decoration: BoxDecoration(
                  color: lightColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.w),
                  ),
                ),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    /// Total orders
                    Tile(
                      title: 'Total orders'.tr,
                      subtitle: '(${PesananController.to.keranjang.length} Menu):',
                      message: PesananController.to.totalPrice.toRupiah(),
                      titleStyle: Theme.of(context).textTheme.headlineSmall,
                      messageStyle: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: blueColor),
                      color: lightColor,
                    ),
                    Divider(color: darkColor2.withOpacity(0.25), height: 2),

                    /// Discount
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                      PesananController.to.discountPrice == 0,
                      widgetBuilder: (context) => Tile(
                        icon: AssetCons.discountIcon,
                        iconSize: 24.r,
                        title: 'Discount'.tr,
                        message: PesananController.to.selectedVoucher.value == null
                            ? 'No discount'.tr
                            : 'Discount can not be combined'.tr,
                        titleStyle: Theme.of(context).textTheme.headlineSmall,
                        messageStyle: Theme.of(context).textTheme.bodySmall,
                        color: lightColor,
                      ),
                      fallbackBuilder: (context) => Tile(
                        icon: AssetCons.discountIcon,
                        iconSize: 24.r,
                        title: 'Discount'.tr,
                        message: PesananController.to.discountPrice.toRupiah(),
                        titleStyle: Theme.of(context).textTheme.headlineSmall,
                        messageStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: redColor),
                        color: lightColor,
                        onTap: PesananController.to.openDiscountDialog,
                      ),
                    ),
                    Divider(color: darkColor2.withOpacity(0.25), height: 2),

                    /// Vouchers
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                      PesananController.to.selectedVoucher.value == null,
                      widgetBuilder: (context) => Tile(
                        icon: AssetCons.voucherIcon,
                        iconSize: 24.r,
                        title: 'voucher'.tr,
                        message: 'Choose voucher'.tr,
                        titleStyle: Theme.of(context).textTheme.headlineSmall,
                        messageStyle: Theme.of(context).textTheme.bodySmall,
                        color: lightColor,
                        onTap: PesananController.to.openVoucherDialog,
                      ),
                      fallbackBuilder: (context) => Tile(
                        icon: AssetCons.voucherIcon,
                        iconSize: 24.r,
                        title: 'voucher'.tr,
                        message: PesananController.to.voucherPrice.toRupiah(),
                        messageSubtitle:
                        PesananController.to.selectedVoucher.value!.nama,
                        titleStyle: Theme.of(context).textTheme.headlineSmall,
                        messageStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: redColor),
                        color: lightColor,
                        onTap: PesananController.to.openVoucherDialog,
                      ),
                    ),
                    Divider(color: darkColor2.withOpacity(0.25), height: 2),

                    /// Payment options
                    Tile(
                      icon: AssetCons.paymentIcon,
                      iconSize: 24.r,
                      title: 'Payment'.tr,
                      message: 'Pay Later',
                      titleStyle: Theme.of(context).textTheme.headlineSmall,
                      messageStyle: Theme.of(context).textTheme.bodySmall,
                      color: lightColor,
                    ),
                  ],
                ),
              ),

              /// Actions
              Container(
                color: lightColor,
                child: Container(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 22.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.w),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: -1,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AssetCons.keranjangIcon,
                        width: 35.r,
                        height: 35.r,
                      ),
                      SizedBox(width: 9.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total payment'.tr,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              PesananController.to.grandTotalPrice.toRupiah(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: blueColor),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: PrimaryButton(
                          text: 'Order Now'.tr,
                          onPressed: PesananController.to.order,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
