import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';
import 'package:magang/shared/widgets/counter.dart';
import 'package:magang/shared/widgets/danger_button.dart';
import 'package:magang/shared/widgets/primary_button.dart';
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
      body: Column(
        children: [
          SizedBox(height: 25.h),
          Center(
            child: Hero(
              tag: 'menu-photo-${MenuController.to.menu.value!.id_menu}',
              child: Image.network(
                MenuController.to.menu.value!.foto,
                height: 181.h,
                width: 234.w,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 25.h),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              MenuController.to.menu.value!.nama,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: blueColor),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(height: 14.h),
                            Text(
                              MenuController.to.menu.value!.deskripsi,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Obx(
                            () => QuantityCounter(
                          quantity: MenuController.to.quantity.value,
                          onIncrement: MenuController.to.onIncrement,
                          onDecrement: MenuController.to.onDecrement,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  Divider(color: darkColor2.withOpacity(0.25), height: 1),
                  Obx(
                        () => Tile(
                      icon: AssetCons.priceIcon,
                      title: 'Price'.tr,
                      message:
                      MenuController.to.keranjang.price.toRupiah(),
                      messageStyle: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: blueColor),
                    ),
                  ),
                  Obx(
                        () => Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                      MenuController.to.level.isNotEmpty,
                      widgetBuilder: (context) => Wrap(
                        children: [
                          Divider(
                            color: darkColor2.withOpacity(0.25),
                            height: 1,
                          ),
                          Tile(
                            icon: AssetCons.levelIcon,
                            title: 'Level'.tr,
                            message: MenuController.to.selectedLevelText,
                            onTap: MenuController.to.openLevelBottomSheet,
                          ),
                        ],
                      ),
                      fallbackBuilder: (context) => const SizedBox(),
                    ),
                  ),
                  Obx(
                        () => Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                      MenuController.to.topping.isNotEmpty,
                      widgetBuilder: (context) => Wrap(
                        children: [
                          Divider(
                            color: darkColor2.withOpacity(0.25),
                            height: 1,
                          ),
                          Tile(
                            icon: AssetCons.topingIcon,
                            title: 'Topping'.tr,
                            message:
                            MenuController.to.selectedToppingsText,
                            onTap:
                            MenuController.to.openToppingBottomSheet,
                          ),
                        ],
                      ),
                      fallbackBuilder: (context) => const SizedBox(),
                    ),
                  ),
                  Divider(color: darkColor2.withOpacity(0.25), height: 1),
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
                  Divider(color: darkColor2.withOpacity(0.25), height: 1),
                  SizedBox(height: 40.h),
                  Obx(() => Conditional.single(
                    context: context,
                    conditionBuilder: (context) =>
                    MenuController.to.status.value == 'success',
                    widgetBuilder: (context) => SizedBox(
                      width: double.infinity,
                      child: Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                        MenuController.to.quantity > 0,
                        widgetBuilder: (context) => PrimaryButton(
                          text: MenuController.to.isInCart.value
                              ? 'Update to order'.tr
                              : 'Add to order'.tr,
                          onPressed: MenuController.to.addToCart,
                        ),
                        fallbackBuilder: (context) => DangerButton(
                          text: 'Delete from order'.tr,
                          onPressed: MenuController.to.deleteFromCart,
                        ),
                      ),
                    ),
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
