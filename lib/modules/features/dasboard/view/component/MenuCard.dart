import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';
import 'package:magang/utils/extensions/currency_extension.dart';

import '../../../../../config/themes/colors.dart';
import '../../../../../shared/widgets/counter.dart';
import '../../../../models/menu_model.dart';

class MenuCard extends StatelessWidget {
  
  final MenuData menu;
  final int? price;
  final bool simple;
  final int quantity;
  final String note;
  final void Function()? onTap;
  final void Function()? onIncrement;
  final void Function()? onDecrement;
  final void Function(String)? onNoteChanged;
  
  ///constructor

  const MenuCard({
    Key? key,
   required this.menu,
    this.price,
    this.simple = false,
    this.quantity=0,
    this.note=' ',
    this.onTap,
    this.onIncrement,
    this.onDecrement,
    this.onNoteChanged,
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
                         (price ?? menu.harga).toRupiah(),
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: blueColor, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.h),
                      if(!simple)
                        Row(
                            children: [
                            SvgPicture.asset(AssetCons.noteIcon, height: 12.h),
                            SizedBox(width: 7.w),
                            SizedBox(
                              width: 150.w,
                              child: TextFormField(
                                initialValue: note,
                                style: Theme.of(context).textTheme.labelMedium,
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Add note'.tr,
                                  border: InputBorder.none,
                                ),
                                onChanged: onNoteChanged,
                              ),
                            ),
                            ],
              ),
    ]
              ),
    ),
    SizedBox(width: 12.w),
    if(!simple)
        QuantityCounter(
          quantity: quantity,
          onIncrement: onIncrement,
          onDecrement: onDecrement,
        ),
          ],
        ),
      ),
    );
  }
}

    