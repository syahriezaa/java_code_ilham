import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/modules/models/promo_model.dart';

class PromoCard extends StatelessWidget {
  final PromoData promo;
  final Function()? onTap;
  final double? width;
  final double? height;
  final bool shadow;

  const PromoCard({
    Key? key,
    required this.promo,
    this.onTap,
    this.width,
    this.height,
    this.shadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Hero(tag: 'promo_card_${promo.id_promo}',
        child:Container(
        width: width??282.2,
        height: height??158.h,
        decoration: BoxDecoration(
          image:DecorationImage(
            image:promo.foto == null
                ?const AssetImage("assets/images/bg_diskon.png")
                :NetworkImage(promo.foto!)as ImageProvider<Object>,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(blueColor.withOpacity(0.9),
                BlendMode.srcATop)
          ),
          borderRadius : BorderRadius.circular(15.w),
          boxShadow:[
            if (shadow)
              BoxShadow(
                color:Colors.black.withOpacity(0.35),
                offset: const Offset(0,2),
                blurRadius :8,
              )
          ],
        ),
          child: Material(
            color: Colors.transparent,
            child:InkWell(
              onTap:onTap,
              borderRadius:BorderRadius.circular(15.w),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children :[
                  Text(promo.typeLabel,
                  style :Theme.of(context)
                  .textTheme.headline6!.copyWith(color:Colors.white),
                  ),
                  SizedBox(width:5.w),
                ]
              )

            )
          )
    ));
  }
}
