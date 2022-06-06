import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magang/utils/extensions/currency_extension.dart';

import '../../../../../config/themes/colors.dart';
import '../../../../models/menu_model.dart';

class MenuCard extends StatelessWidget {
  
  final MenuData menu;
  final bool simple;
  final void Function()? onTap;
  final void Function()? onIncrement;
  final void Function()? onDecrement;
  
  ///constructor

  const MenuCard({
    Key? key,
    required this.menu,
    this.simple = false,
    this.onTap,
    this.onIncrement,
    this.onDecrement,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.w),
      child: Ink(
        padding: EdgeInsets.all(7.w),
        decoration: BoxDecoration(
          color:lightColor,
          borderRadius: BorderRadius.circular(10.w),
          boxShadow: [
            BoxShadow(
              color: darkColor,
              offset: const Offset(0,2),
              blurRadius: 8,
              spreadRadius: -1,
            ),
          ],
        ),
        ///Menu Image
        child: Row(
          children: [
            Container(
              height:75.w,
              width:75.w,
              padding: EdgeInsets.all(7.w),
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(10.w),
                color:greyColor2,
              ),
              child:Hero(
                tag: 'menu-photo-${menu.id_menu}',
                child:Image.network(
                  menu.foto,
                  fit:BoxFit.contain,
                  height: 75,
                  width: 75,
                ),
              ),


            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text(
                  menu.nama,
                style:Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.w400),
                overflow: TextOverflow.ellipsis,
              ),
                      SizedBox(height: 4.h),
                      Text(
                        menu.harga.toRupiah(),
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: blueColor, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.h),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}

    