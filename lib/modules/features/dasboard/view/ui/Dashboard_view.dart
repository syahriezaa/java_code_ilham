import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magang/modules/features/dasboard/view/ui/home_view.dart';
import 'package:magang/modules/features/pesanan/view/ui/pesanan_view.dart';
import 'package:magang/modules/features/profile/view/ui/profil_view.dart';
import '../../../../../config/themes/colors.dart';
import '../../controller/dasboard_controller.dart';

class DashboardView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
  Get.put(DashboardController());

    return Scaffold(
      body: Obx(
          ()=>IndexedStack(
            index : DashboardController.to.tabIndex.value,
              children : const[
                HomeView(),
                PesananView(),
                ProfileView(),
              ]
          )
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top:Radius.circular(30.w)),
        child: Obx(
            ()=>BottomNavigationBar(
              onTap:DashboardController.to.changeTabIndex,
              currentIndex: DashboardController.to.tabIndex.value,
              backgroundColor : darkColor2,
              selectedLabelStyle: Theme.of(context).textTheme.caption,
              unselectedLabelStyle: Theme.of(context).textTheme.caption,
              selectedItemColor: Colors.white,
              unselectedItemColor: greyColor,
              items: [
                BottomNavigationBarItem(
                  icon :Padding(
                    padding:EdgeInsets.only(bottom:0.5.h),
                      child:SvgPicture.asset(
                          "assets/svg/ic_home.svg",
                          color:darkColor,
                          height:27.h
                      ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom:0.5.h),
                    child:SvgPicture.asset(
                        "assets/svg/ic_home.svg",
                        color:Colors.white,
                        height:27.h
                    ),
                  ),
                  label: 'Home'.tr,
                ),
                BottomNavigationBarItem(
                    icon: Padding(
                        padding: EdgeInsets.only(bottom:0.5.h),
                        child:SvgPicture.asset(
                            'assets/svg/ic_pesanan.svg',
                            color: darkColor,
                          height:27.h
                        )
                    ),
                    activeIcon: Padding(
                        padding: EdgeInsets.only(bottom:0.5.h),
                        child:SvgPicture.asset(
                            'assets/svg/ic_pesanan.svg',
                            color: Colors.white,
                            height:27.h
                        )
                    ),
                    label:'Order'.tr,
                ),
                BottomNavigationBarItem(
                    icon: Padding(
                        padding: EdgeInsets.only(bottom:0.5.h),
                        child:SvgPicture.asset(
                            'assets/svg/ic_profil.svg',
                            color: darkColor,
                            height:27.h
                        )
                    ),
                    activeIcon: Padding(
                        padding: EdgeInsets.only(bottom:0.5.h),
                        child:SvgPicture.asset(
                            'assets/svg/ic_profil.svg',
                            color: Colors.white,
                            height:27.h
                        )
                    ),
                  label:"Profile".tr,
                )
              ],
            )
        ),

      ),
    );
  }
}

