import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/shimmer.dart';
import '../controller/dasboard_controller.dart';
import 'component/promo_card.dart';
import 'component/search_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    return Scaffold(
      body: RefreshIndicator(
        onRefresh:()async{
          await Future.any([DashboardController.to.getPromo()]);
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
          ///promo
          SliverList(
              delegate: SliverChildListDelegate(promoSection(context)),
          )
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
                onTap: () {}
              ),
              itemCount: DashboardController.to.listPromo.length,
              separatorBuilder: (context, index) => SizedBox(width: 25.w),
            ),
          ),
        ),
      )
    ];
  }
}
