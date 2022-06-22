import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magang/constant/common/constants.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';
import 'package:magang/utils/extensions/currency_extension.dart';

import '../../../../../config/themes/colors.dart';
import '../../../../../shared/widgets/counter.dart';
import '../../../../models/menu_model.dart';

class MenuCard extends StatelessWidget {
  
  final MenuData menu;
  final int? price;
  final bool isSimple;
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
    this.quantity=0,
    this.note=' ',
    this.onTap,
    this.onIncrement,
    this.onDecrement,
    this.onNoteChanged,
  }) : this.isSimple = false,
        super(key: key);

  const MenuCard.simple({
    Key? key,
    required this.menu,
    this.price,
    this.quantity = 0,
    this.note = '',
    this.onTap,
    this.onIncrement,
    this.onDecrement,
    this.onNoteChanged,
  })  : isSimple = true,
        super(key: key);

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
          boxShadow: const [
            BoxShadow(
              color: darkColor,
              offset: Offset(0,2),
              blurRadius: 5,
              spreadRadius: -1,
            ),
          ],
        ),

        child: Row(
          children: [
            ///Menu Image
            Container(
              height: isSimple ? 75.r : 90.r,
              width: isSimple ? 75.r : 90.r,
              padding: EdgeInsets.all(7.w),
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(10.w),
                color:greyColor2,
              ),
              child:Hero(
                tag: 'menu-photo-${menu.id_menu}',
                child: CachedNetworkImage(
                  imageUrl: menu.foto,
                  fit: BoxFit.contain,
                  errorWidget: (context, _, __) => CachedNetworkImage(
                    imageUrl: AppConstant.defaultMenuPhoto,
                    fit: BoxFit.contain,
                  ),
                ),
              ),


            ),
            const SizedBox(width: 12),
            ///info menu
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Nama menu
                  Text(
                    menu.nama,
                    style: Get.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),

                  /// Harga menu
                  Text(
                    (price ?? menu.harga).toRupiah(),
                    style: Get.textTheme.bodyMedium!.copyWith(
                        color: AppColor.blueColor, fontWeight: FontWeight.bold),
                  ),
                  5.verticalSpacingRadius,

                  /// Catatan menu
                  Conditional.single(
                    context: context,
                    conditionBuilder: (context) => !isSimple,
                    widgetBuilder: (context) => Row(
                      children: [

                        /// Icon edit
                        SvgPicture.asset(AssetCons.noteIcon, height: 12.r),
                        7.horizontalSpaceRadius,

                        /// Text field
                        Expanded(
                          child: TextFormField(
                            initialValue: note,
                            style: Get.textTheme.labelMedium,
                            decoration: InputDecoration.collapsed(
                              hintText: 'Add note'.tr,
                              border: InputBorder.none,
                            ),
                            onChanged: onNoteChanged,
                          ),
                        ),
                      ],
                    ),
                    fallbackBuilder: (context) => const SizedBox(),
                  ),
                ],
              ),
            ),

            SizedBox(width: 12.w),
            Conditional.single(
                context: context,
                conditionBuilder: (context) => !isSimple,
                widgetBuilder: (context) => Container(
                  height: 75.r,
                  padding: EdgeInsets.only(left: 12.r, right: 5.r),
                  child: InkWell(
                    onTap: () {},
                    splashFactory: NoSplash.splashFactory,
                    child: QuantityCounter(
                      quantity: quantity,
                      onIncrement: onIncrement,
                      onDecrement: onDecrement,
              ),
      ),
    ),
        fallbackBuilder: (context) => const SizedBox(),
    )
          ],
        ),
      ),
    );
  }
}

    