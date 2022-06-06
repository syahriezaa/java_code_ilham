import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:magang/config/themes/colors.dart';

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
        children:[
          SizedBox(height: 25.h,),
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
          SizedBox(height: 25.h,),
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
        ]
      ),
    );
  }
}
