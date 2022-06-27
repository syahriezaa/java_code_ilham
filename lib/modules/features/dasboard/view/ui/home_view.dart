
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';

import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';
import 'package:magang/modules/features/dasboard/view/component/loading_menu.dart';
import 'package:magang/modules/features/dasboard/view/component/menu_list.dart';
import 'package:magang/modules/features/keranjang/contrrollers/cart_controller.dart';
import 'package:magang/shared/style/shapes.dart';
import 'package:magang/shared/widgets/custom_err_vertical.dart';
import 'package:magang/shared/widgets/empty_data.dart';
import 'package:magang/shared/widgets/shimmer.dart';
import 'package:magang/modules/features/dasboard/view/component/filter_menu.dart';
import 'package:magang/modules/features/dasboard/view/component/promo_card.dart';
import 'package:magang/modules/features/dasboard/view/component/search_bar.dart';

import '../../controller/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.h,
        backgroundColor: Colors.white,
        elevation: 2,
        title: Column(
          children: [
            10.verticalSpacingRadius,
            Row(
              children: [
                Expanded(
                  child: SearchBar(
                    controller: HomeController.to.searchController,
                    onChanged: HomeController.to.setQueryMenu,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Get.toNamed(AppRoutes.keranjangView);
                  },
                  splashRadius: 30.r,
                  visualDensity: VisualDensity.compact,
                  icon: Obx(
                        () => Badge(
                      showBadge: PesananController.to.keranjang.isNotEmpty,
                      badgeColor: AppColor.blueColor,
                      badgeContent: Text(
                        PesananController.to.keranjang.length.toString(),
                        style: Get.textTheme.labelMedium!
                            .copyWith(color: Colors.white),
                      ),
                      child: Icon(Icons.shopping_cart, size: 30.r),
                    ),
                  ),
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
        shape: CustomShape.bottomRoundedShape,
      ),
      body: RefreshIndicator(
        onRefresh: HomeController.to.reload,
        child: ListView(
          children: [
            /// Promo section
            ...promoSection(context),
            TextButton(
              onPressed: () => throw Exception(),
              child: const Text("Throw Test Exception"),
            ),
            /// Menu section
            listCategoryMenu(context),
            17.verticalSpacingRadius,

            Obx(
                  () => Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                HomeController.to.categoryMenu.value != 'drink',
                widgetBuilder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: foodList(context),
                ),
                fallbackBuilder: (context) => const SizedBox(),
              ),
            ),

            Obx(
                  () => Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                HomeController.to.categoryMenu.value != 'food',
                widgetBuilder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: DrinkList(context),
                ),
                fallbackBuilder: (context) => const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///Bagian Promo
  List<Widget>promoSection(BuildContext context) {
    return[
      SizedBox(height:25.h),

      Row(
        children: [
          SizedBox(width: 25.w),
          SvgPicture.asset('assets/svg/ic_promo.svg'),
          SizedBox(width: 25.w),
          Text("Available Promo".tr,
          style:Theme.of(context).textTheme.headline6),
          SizedBox(width: 25.w)
        ],
      ),
      SizedBox(height:7.h),

      ///promo list

      SizedBox(height:188.h,
        child: Obx(
              () => ConditionalSwitch.single<String>(
            context: context,
            valueBuilder: (context) => HomeController.to.statusPromo.value,
            caseBuilders: {
              'loading': (context) => SizedBox(
                height: 188.r,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.r,
                    vertical: 15.r,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, _) => RectShimmer(
                    width: 282.r,
                    height: 158.r,
                    radius: 15.r,
                  ),
                  itemCount: 5,
                  separatorBuilder: (context, _) => 25.horizontalSpaceRadius,
                ),
              ),
              'empty': (context) => Padding(
                padding: EdgeInsets.only(bottom: 15.r),
                child: EmptyDataVertical(width: 100.r),
              ),
              'error': (context) => CustomErrorVertical(
                message: HomeController.to.messagePromo.value,
              ),
            },
            fallbackBuilder: (context) => ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: 15.h,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => PromoCard(
                promo: HomeController.to.listPromo.elementAt(index),
                onTap: (){
                  FocusScope.of(context).unfocus();
                  Get.toNamed(
                    AppRoutes.PromoDetailView,
                    arguments:HomeController.to.listPromo.elementAt(index));},
              ),
              itemCount: HomeController.to.listPromo.length,
              separatorBuilder: (context, index) => SizedBox(width: 25.w),
            ),
          ),
        ),
      ),
      SizedBox(height:5.h),
    ];
  }
  ///filter menu
  Widget listCategoryMenu(BuildContext context) {
    final List<Map<String, String>> filters = [
      {'name': 'All Menu'.tr, 'value': 'all', 'icon': AssetCons.listIcon},
      {'name': 'Food'.tr, 'value': 'food', 'icon': AssetCons.foodIcon},
      {'name': 'Drink'.tr, 'value': 'drink', 'icon': AssetCons.drinksIcon},
    ];

    return SizedBox(
      height: 45.r,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 5.r),
        itemBuilder: (context, index) => Obx(
              () => FilterMenu(
            isSelected:
            HomeController.to.categoryMenu.value == filters[index]['value'],
            onTap: () =>
                HomeController.to.setCategoryMenu(filters[index]['value']!),
            iconPath: filters[index]['icon']!,
            text: filters[index]['name']!,
          ),
        ),
        itemCount: filters.length,
        separatorBuilder: (context, index) => 13.horizontalSpaceRadius,
      ),
    );
  }


  /// bagian makanan
  List<Widget> Menu (BuildContext context){
    return [
      Row(
        children: [
          25.horizontalSpaceRadius,
          SvgPicture.asset(
            AssetCons.foodIcon,
            width: 20.r,
            height: 20.r,
            color: AppColor.blueColor,
          ),
          10.horizontalSpaceRadius,
          Text(
            'Food'.tr,
            style:
            Get.textTheme.titleMedium!.copyWith(color: AppColor.blueColor),
          ),
        ],
      ),

      /// Food Section - List
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 17.r),
        child: ConditionalSwitch.single<String>(
          context: context,
          valueBuilder: (context) => HomeController.to.statusMenu.value,
          caseBuilders: {
            'loading': (context) => const LoadingMenu(),
            'empty': (context) => EmptyDataVertical(width: 100.r),
            'error': (context) => CustomErrorVertical(
              message: HomeController.to.messageMenu.value,
            ),
          },
          fallbackBuilder: (context) => MenuList(
            data: HomeController.to.foodMenu,
          ),
        ),
      ),
      17.verticalSpacingRadius,
    ];
  }
  ///List Menkanan
  List<Widget> foodList(BuildContext context){
    return [
      Row(
        children:[
          SizedBox(width:25.w),
          SvgPicture.asset(
              AssetCons.foodIcon,
              width: 23.w,
              color:blueColor
          ),
          SizedBox(width:10.w),
          Text(
            'Food'.tr,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(
              color:blueColor,
            ),
          ),
        ]
      ),
      ///list makanan
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 17.r),
        child: ConditionalSwitch.single<String>(
          context: context,
          valueBuilder: (context) => HomeController.to.statusMenu.value,
          caseBuilders: {
            'loading': (context) => const LoadingMenu(),
            'empty': (context) => EmptyDataVertical(width: 100.r),
            'error': (context) => CustomErrorVertical(
              message: HomeController.to.messageMenu.value,
            ),
          },
          fallbackBuilder: (context) => MenuList(
            data: HomeController.to.foodMenu,
          ),
        ),
      ),
    ];
  }
  ///Bagian minuman
  List<Widget> DrinkList(BuildContext context){
    return [
      Row(
          children:[
            SizedBox(width:25.w),
            SvgPicture.asset(
                AssetCons.drinksIcon,
                width: 23.w,
                color:blueColor
            ),
            SizedBox(width:10.w),
            Text(
              'Drink'.tr,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(
                color:blueColor,
              ),
            ),
          ]
      ),
      ///List Minuman
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 17.r),
        child: ConditionalSwitch.single<String>(
          context: context,
          valueBuilder: (context) => HomeController.to.statusMenu.value,
          caseBuilders: {
            'loading': (context) => const LoadingMenu(),
            'empty': (context) => EmptyDataVertical(width: 100.r),
            'error': (context) => CustomErrorVertical(
              message: HomeController.to.messageMenu.value,
            ),
          },
          fallbackBuilder: (context) => MenuList(
            data: HomeController.to.drinkMenu,
          ),
        ),
      ),
    ];
  }
}
