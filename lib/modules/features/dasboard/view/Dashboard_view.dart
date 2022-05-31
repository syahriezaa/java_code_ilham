import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/themes/colors.dart';
import '../controller/dasboard_controller.dart';

class DashboardView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
          ()=>IndexedStack(
            index : DashboardController.to.tabIndex.value,
              children : const[
                //HomeView(),
              ]
          )
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top:Radius.circular(30.w)),
        child: Obx(
            ()=>BottomNavigationBar(
              onTap:DashboardController.to.changeTabIndex.value,
              backgroundColor : darkColor2,
              selectedLabelStyle: Theme.of(context).textTheme.caption,
              unselectedLabelStyle: Theme.of(context).textTheme.caption,
              selectedItemColor: Colors.white,
              unselectedItemColor: greyColor,
              items: [
                BottomNavigationBarItem(
                  icon :
                )
              ],
            )
        ),

      ),
    );
  }
}

