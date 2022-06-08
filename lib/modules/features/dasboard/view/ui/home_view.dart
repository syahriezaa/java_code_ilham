
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magang/modules/features/dasboard/view/component/MenuCard.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../config/themes/colors.dart';
import '../../../../../constant/core/assets_conts/asset_cons.dart';
import '../../../../../shared/widgets/shimmer.dart';
import '../../controller/dasboard_controller.dart';
import '../../controller/dasboard_controller.dart';
import '../component/filter_menu.dart';
import '../component/promo_card.dart';
import '../component/search_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    return Scaffold(
      body: RefreshIndicator(
        onRefresh:()async{
          await Future.any([
            DashboardController.to.getPromo(),
              DashboardController.to.getListMenu(),
          ]);
        } ,
      child: CustomScrollView(
        slivers: [
          ///Appbar
          SliverAppBar(
            pinned: true,
            forceElevated: true,
            backgroundColor:Colors.white,
            centerTitle: true,
            title : SearchBar(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
              bottom:Radius.circular(30.w),
              )
            ),
          ),
          ///Tampilan list promo
          SliverList(
              delegate: SliverChildListDelegate(promoSection(context)),
          ),
          SliverToBoxAdapter(
            child: Obx(
                  () => Column(
                children: [
                  ...Menu(context),
                  if (DashboardController.to.categoryMenu.value == 'all' ||
                      DashboardController.to.categoryMenu.value == 'food')
                    ...FoodList(context),
                  if (DashboardController.to.categoryMenu.value == 'all')
                    SizedBox(width: 25.w),
                  if (DashboardController.to.categoryMenu.value == 'all' ||
                      DashboardController.to.categoryMenu.value == 'drink')
                    ...DrinkList(context),
                ],
              ),
            ),
          ),
        ],
      ),
      )
    );
  }
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
            valueBuilder: (context) => DashboardController.to.statusPromo.value,
            caseBuilders: {
              'loading': (context) => ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: 25.w,
                  vertical: 15.h,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, _) => RectShimmer(
                  width: 282.w,
                  height: 158.h,
                  radius: 15.w,
                ),
                itemCount: 5,
                separatorBuilder: (context, _) => SizedBox(width: 25.w),
              ),
              'error': (context) => Center(
                child: Text(DashboardController.to.messagePromo.value),
              ),
            },
            fallbackBuilder: (context) => ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: 15.h,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => PromoCard(
                promo: DashboardController.to.listPromo.elementAt(index),
                onTap: ()=>Get.toNamed(
                    AppRoutes.PromoDetailView,
                    arguments:DashboardController.to.listPromo.elementAt(index)),
              ),
              itemCount: DashboardController.to.listPromo.length,
              separatorBuilder: (context, index) => SizedBox(width: 25.w),
            ),
          ),
        ),
      ),
      SizedBox(height:5.h),
    ];
  }
  List<Widget> Menu (BuildContext){
    return[
      ///Filter Menu
      SizedBox(height:45.h,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 25.w,vertical:5.h),
          children:[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              child: Obx(
                  ()=>FilterMenu(
                    isSelected: DashboardController.to.categoryMenu.value == 'all',
                    onTap:()=>DashboardController.to.categoryMenu('all'),
                    iconPath: AssetCons.listIcon,
                    text:'all menu'.tr,
                  ),
              ),
            ),
            SizedBox(height:13.w),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              child: Obx(
                  ()=>FilterMenu(
                    isSelected: DashboardController.to.categoryMenu.value == 'food',
                    onTap:()=>DashboardController.to.categoryMenu.value = 'food',
                    iconPath: AssetCons.foodIcon,
                    text:'food menu'.tr,
                  ),
              ),
            ),
            SizedBox(height:13.w),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              child: Obx(
                  ()=>FilterMenu(
                    isSelected: DashboardController.to.categoryMenu.value == 'drink',
                    onTap:()=>DashboardController.to.categoryMenu.value = 'drink',
                    iconPath: AssetCons.drinksIcon,
                    text:'drink menu'.tr,
                  ),
              ),
            ),
          ]
        ),
      ),
      SizedBox(height:17.h),
    ];
  }
  ///List Menkanan
  List<Widget> FoodList(BuildContext context){
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
            'food'.tr,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(
              color:blueColor,
            ),
          ),
        ]
      ),
      Padding(
        padding:EdgeInsets.symmetric(horizontal:25.w,vertical:17.h),
        child : ConditionalSwitch.single<String>(
          context: context,
          valueBuilder:(context)=>DashboardController.to.statusMenu.value,
          caseBuilders: {
            'loading':(context)=>Wrap(
              runSpacing: 17.h,
              children:List.generate(2,
                      (i) => RectShimmer(height:89.h,
                      radius: 10.w,),
              ),
            ),
            'error':(context)=>Center(
              child:Text(
                DashboardController.to.messageMenu.value,
                textAlign: TextAlign.center,
              ),
            ),

          },
          fallbackBuilder: (BuildContext context) {
            final foods = DashboardController.to.foodMenu;

            if(foods.isEmpty){
              return Center(
                  child: Text('no_data'.tr,textAlign: TextAlign.center,)
              );
            }else{
              return Wrap(
                runSpacing: 17.h,
                children: foods
                    .map<Widget>(
                      (menu) => MenuCard(
                        menu: menu,
                        simple: true,
                        onTap: () {
                          print("click ");
                          Get.toNamed(
                              AppRoutes.MenuDetailView,
                              arguments: menu);
                          },
                  ),
                ).toList(),
              );
            }
        },
        )
      )
    ];
  }
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
              'drink'.tr,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(
                color:blueColor,
              ),
            ),
          ]
      ),
      Padding(
          padding:EdgeInsets.symmetric(horizontal:25.w,vertical:17.h),
          child : ConditionalSwitch.single<String>(
            context: context,
            valueBuilder:(context)=>DashboardController.to.statusMenu.value,
            caseBuilders: {
              'loading':(context)=>Wrap(
                runSpacing: 17.h,
                children:List.generate(2,
                      (i) => RectShimmer(height:89.h,
                    radius: 10.w,),
                ),
              ),
              'error':(context)=>Center(
                child:Text(
                  DashboardController.to.messageMenu.value,
                  textAlign: TextAlign.center,
                ),
              ),

            },
            fallbackBuilder: (BuildContext context) {
              final foods = DashboardController.to.drinkMenu;

              if(foods.isEmpty){
                return Center(
                    child: Text('no_data'.tr,textAlign: TextAlign.center,)
                );
              }else{
                return Wrap(
                  runSpacing: 17.h,
                  children: foods
                      .map<Widget>(
                        (menu) => MenuCard(
                      menu: menu,
                      simple: true,
                      onTap: () {     Get.toNamed(
                          AppRoutes.MenuDetailView,
                          arguments: menu);},
                    ),
                  ).toList(),
                );
              }
            },
          )
      )
    ];
  }
}
