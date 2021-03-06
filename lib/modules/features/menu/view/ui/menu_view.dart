import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';
import 'package:magang/shared/widgets/counter.dart';
import 'package:magang/shared/widgets/danger_button.dart';
import 'package:magang/shared/widgets/primary_button.dart';
import 'package:magang/shared/widgets/shimmer.dart';
import 'package:magang/shared/widgets/tiles.dart';
import 'package:magang/utils/extensions/currency_extension.dart';

import '../../controllers/menu_controller.dart';


class MenuView extends StatelessWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MenuController());
    return Scaffold(
      appBar: AppBar(
        elevation:2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black,size:32.w),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
            'Detail Menu'.tr,
              style: Theme.of(context).textTheme.titleMedium,
              ),
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.w),
          ),
        ),
        ),
          backgroundColor: lightColor,
      body:  CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(25.r),
                    child: Center(
                      child: Hero(
                        tag: 'menu-${MenuController.to.menu.value!.id_menu}',
                        child: CachedNetworkImage(
                          imageUrl: MenuController.to.menu.value!.foto,
                          height: 181.r,
                          width: 234.r,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 22.r, vertical: 45.r),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                MenuController.to.menu.value!.nama,
                                style: Get.textTheme.titleMedium!
                                    .copyWith(color: AppColor.blueColor),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            10.horizontalSpaceRadius,
                            Obx(
                                  () => QuantityCounter(
                                quantity: MenuController.to.quantity.value,
                                onIncrement: MenuController.to.onIncrement,
                                onDecrement: MenuController.to.onDecrement,
                              ),
                            ),
                          ],
                        ),
                        14.verticalSpacingRadius,
                        Text(
                          MenuController.to.menu.value!.deskripsi,
                          style: Get.textTheme.labelMedium,
                          textAlign: TextAlign.left,
                        ),
                        40.verticalSpacingRadius,
                        Divider(
                            color: AppColor.darkColor2.withOpacity(0.25),
                            height: 2.r),
                        Obx(
                              () => Tile(
                            icon: AssetCons.priceIcon,
                            title: 'Price'.tr,
                            message:
                            MenuController.to.keranjang.price.toRupiah(),
                            messageStyle: Get.textTheme.headlineSmall!
                                .copyWith(color: AppColor.blueColor),
                          ),
                        ),
                        Obx(
                              () => ConditionalSwitch.single(
                            context: context,
                            valueBuilder: (context) =>
                            MenuController.to.statusLevels.value,
                            caseBuilders: {
                              'success': (context) => Wrap(
                                children: [
                                  Divider(
                                    color: AppColor.darkColor2.withOpacity(0.25),
                                    height: 2.r,
                                  ),
                                  Tile(
                                    icon: AssetCons.levelIcon,
                                    title: 'Level'.tr,
                                    message:
                                    MenuController.to.selectedLevelText,
                                    onTap: MenuController
                                        .to.openLevelBottomSheet,
                                  ),
                                ],
                              ),
                              'loading': (context) => Wrap(
                                children: [
                                  Divider(
                                    color: AppColor.darkColor2.withOpacity(0.25),
                                    height: 2.r,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.r),
                                    child: RectShimmer(height: 32.r),
                                  ),
                                ],
                              ),
                            },
                            fallbackBuilder: (context) => const SizedBox(),
                          ),
                        ),
                        Obx(
                              () => ConditionalSwitch.single(
                            context: context,
                            valueBuilder: (context) =>
                            MenuController.to.statusLevels.value,
                            caseBuilders: {
                              'success': (context) => Wrap(
                                children: [
                                  Divider(
                                    color: AppColor.darkColor2.withOpacity(0.25),
                                    height: 2.r,
                                  ),
                                  Tile(
                                    icon: AssetCons.topingIcon,
                                    title: 'Topping'.tr,
                                    message: MenuController
                                        .to.selectedToppingsText,
                                    onTap: MenuController
                                        .to.openToppingBottomSheet,
                                  ),
                                ],
                              ),
                              'loading': (context) => Wrap(
                                children: [
                                  Divider(
                                    color: AppColor.darkColor2.withOpacity(0.25),
                                    height: 2.r,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.r),
                                    child: RectShimmer(height: 32.r),
                                  ),
                                ],
                              ),
                            },
                            fallbackBuilder: (context) => const SizedBox(),
                          ),
                        ),
                        Divider(
                            color: AppColor.darkColor2.withOpacity(0.25),
                            height: 2.r),
                        Obx(
                              () => Tile(
                            icon: AssetCons.noteIcon,
                            title: 'Note'.tr,
                            message: MenuController.to.note.isNotEmpty
                                ? MenuController.to.note.value
                                : 'Add note'.tr,
                            onTap: MenuController.to.openNoteBottomSheet,
                          ),
                        ),
                        Divider(
                            color: AppColor.darkColor2.withOpacity(0.25),
                            height: 2.r),
                        40.verticalSpacingRadius,
                        Obx(
                              () => ConditionalSwitch.single(
                            context: context,
                            valueBuilder: (context) =>
                            MenuController.to.status.value,
                            caseBuilders: {
                              'loading': (context) => RectShimmer(
                                height: 50.r,
                                radius: 30.r,
                              ),
                              'success': (context) => SizedBox(
                                width: double.infinity,
                                child: Conditional.single(
                                  context: context,
                                  conditionBuilder: (context) =>
                                  MenuController.to.quantity > 0,
                                  widgetBuilder: (context) => PrimaryButton(
                                    text: MenuController
                                        .to.isInCart.value
                                        ? 'Update to order'.tr
                                        : 'Add to order'.tr,
                                    onPressed: MenuController.to.addToCart,
                                  ),
                                  fallbackBuilder: (context) => DangerButton(
                                    text: 'Delete from order'.tr,
                                    onPressed:
                                    MenuController.to.deleteFromCart,
                                  ),
                                ),
                              ),
                            },
                            fallbackBuilder: (context) => const SizedBox(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      );
  }
}
