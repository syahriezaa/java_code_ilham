import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';
import 'package:magang/shared/widgets/danger_button.dart';
import 'package:magang/shared/widgets/primary_button.dart';
import 'package:magang/shared/widgets/tiles.dart';

import '../../../../models/voucher_model.dart';
import '../../contrrollers/cart_controller.dart';

class VucherDetail extends StatelessWidget {
  const VucherDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VoucherData voucher = Get.arguments as VoucherData;
    return Scaffold(
      backgroundColor: lightColor,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 32.w),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'Detail voucher'.tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.w),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Hero(
              tag: 'voucher-image-${voucher.id_voucher}',
              child: Material(
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.w),
                    image: DecorationImage(
                      image: NetworkImage(voucher.info_voucher),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const AspectRatio(aspectRatio: 379 / 177),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 45.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.w)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voucher.nama,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: blueColor),
                  ),
                  if (voucher.catatan != null)
                    Html(
                      data: voucher.catatan,
                      style: {
                        '*': Style.fromTextStyle(
                          Theme.of(context).textTheme.labelMedium!,
                        ),
                        'body': Style(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                        ),
                      },
                    ),
                  SizedBox(height: 40.h),
                  Divider(color: darkColor2.withOpacity(0.25), height: 1),
                  Tile(
                    icon: AssetCons.dateIcon,
                    title: 'Valid date'.tr,
                    message:
                    '${DateFormat('dd/MM/yyyy').format(voucher.periode_mulai)} - ${DateFormat('dd/MM/yyyy').format(voucher.periode_selesai)}',
                    titleStyle: Theme.of(context).textTheme.headlineSmall,
                    messageStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Divider(color: darkColor2.withOpacity(0.25), height: 2),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 22.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.w)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: -1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Conditional.single(
            context: context,
            conditionBuilder: (context) =>
            voucher != PesananController.to.selectedVoucher.value,
            widgetBuilder: (context) => PrimaryButton(
              text: 'Use voucher'.tr,
              onPressed: () {
                PesananController.to.setVoucher(voucher);
                Get.until(ModalRoute.withName(AppRoutes.PesananView));
              },
            ),
            fallbackBuilder: (context) => DangerButton(
              text: 'Use voucher later'.tr,
              onPressed: () {
                PesananController.to.setVoucher(null);
                Get.until(ModalRoute.withName(AppRoutes.PesananView));
              },
            ),
          ),
        ),
      ),
    );
  }
}
