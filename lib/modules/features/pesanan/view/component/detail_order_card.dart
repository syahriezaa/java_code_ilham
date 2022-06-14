import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';
import 'package:magang/modules/models/detail_order.dart';
import 'package:magang/shared/widgets/counter.dart';
import 'package:magang/utils/extensions/currency_extension.dart';

import '../../../../../constant/common/constants.dart';


class DetailOrderCard extends StatelessWidget {
  final OrderDetail detailOrder;

  const DetailOrderCard(this.detailOrder, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.all(7.r),
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.darkColor2.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Row(
        children: [
          /* Image */
          Container(
            height: 90.r,
            width: 90.r,
            margin: EdgeInsets.only(right: 12.r),
            padding: EdgeInsets.all(5.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColor.lightColor,
            ),
            child: Image.network(
              detailOrder.foto ?? AppConstant.defaultMenuPhoto,
              fit: BoxFit.contain,
              errorBuilder: (context, _, __) => Image.network(
                AppConstant.defaultMenuPhoto,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detailOrder.nama,
                  style: Get.textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  int.parse(detailOrder.harga).toRupiah(),
                  style: Get.textTheme.bodyMedium!.copyWith(
                      color: AppColor.blueColor, fontWeight: FontWeight.bold),
                ),
                5.verticalSpacingRadius,
                Row(
                  children: [
                    SvgPicture.asset(AssetCons.noteIcon, height: 12.r),
                    7.horizontalSpaceRadius,
                    Expanded(
                      child: TextFormField(
                        initialValue: detailOrder.catatan,
                        style: Get.textTheme.labelMedium,
                        enabled: false,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Add note'.tr,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 75.r,
            padding: EdgeInsets.only(left: 12.r, right: 5.r),
            child: QuantityCounter(quantity: detailOrder.jumlah),
          ),
        ],
      ),
    );
  }
}
