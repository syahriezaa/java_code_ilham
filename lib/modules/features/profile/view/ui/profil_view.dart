import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';
import 'package:magang/modules/features/profile/controller/profile_controller.dart';
import 'package:magang/shared/widgets/primary_button.dart';
import 'package:magang/shared/widgets/tiles.dart';
import 'package:magang/utils/extensions/string_case_extension.dart';

import '../../../../../config/themes/colors.dart';
import '../../../../../constant/common/constants.dart';
import '../../../../../shared/style/shapes.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      appBar:AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: Text(
          'Profile'.tr,style: TextStyle(color: AppColor.blueColor),
        ),
        centerTitle: true,
        shape:  CustomShape.bottomRoundedShape,
      ),
   body: RefreshIndicator(
     onRefresh: ProfileController.to.loadData,
     child: Container(
       decoration: BoxDecoration(
         image: DecorationImage(
           image: AssetImage(AssetCons.background),
           fit: BoxFit.cover,
         ),
       ),
       child:ListView(
         padding: EdgeInsets.symmetric(
             horizontal : 16.r,
             vertical: 16.r),
         children: [
           Center(
             child: Container(
               width: 170.r,
                height: 170.r,
               clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  ),
               child: Stack(
                 children: [
                   Obx(
                       ()=> Conditional.single(
                         context: context,
                         conditionBuilder:(context)=>
                             ProfileController.to.user.value.foto!=null,
                         widgetBuilder: (context)=>
                             Image.network(
                               ProfileController.to.user.value.foto!,
                               fit: BoxFit.cover,
                             ),
                         fallbackBuilder: (context)=>
                             Image.asset(
                               AssetCons.bgProfile,
                               width: 170.r,
                                height: 170.r,
                               fit: BoxFit.cover,
                             ),
                       )
                   ),
                   Align(
                     alignment: Alignment.bottomCenter,
                     child: Material(
                       color: AppColor.blueColor,
                       child: InkWell(
                         onTap: ProfileController.to.openUpdatePhotoDialog,
                         child: Container(
                           width: double.infinity,
                           padding: EdgeInsets.only(top: 10.r, bottom: 15.r),
                           child: Text(
                             'Change'.tr,
                             style: Get.textTheme.labelMedium!
                                 .copyWith(color: Colors.white),
                             textAlign: TextAlign.center,
                           ),
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
           ///ktp
           Obx(
                 () => Conditional.single(
               context: context,
               conditionBuilder: (context) =>
               ProfileController.to.user.value.ktp != null,
               widgetBuilder: (context) => Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Icon(Icons.check, color: AppColor.greenColor, size: 20.r),
                   8.horizontalSpaceRadius,
                   Text(
                     'You have verified your ID card'.tr,
                     style: Get.textTheme.labelMedium!
                         .copyWith(color: AppColor.blueColor),
                   ),
                 ],
               ),
               fallbackBuilder: (context) => Center(
                 child: InkWell(
                   onTap: ProfileController.to.openVerifyIDDialog,
                   borderRadius: BorderRadius.circular(5.r),
                   child: Padding(
                     padding: EdgeInsets.symmetric(
                       horizontal: 10,
                       vertical: 5.r,
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         SvgPicture.asset(
                           AssetCons.ktpIcon,
                           width: 18.r,
                           height: 18.r,
                           color: AppColor.blueColor,
                         ),
                         8.horizontalSpaceRadius,
                         Text(
                           'Verify your ID card now!'.tr,
                           style: Get.textTheme.labelMedium!
                               .copyWith(color: AppColor.blueColor),
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
             ),
           ),
           20.verticalSpacingRadius,

           Padding(
             padding: EdgeInsets.only(left: 20.r),
            child: Text(""
                "Accoount Info".tr,
            style: Get.textTheme.titleMedium!
                    .copyWith(color: AppColor.blueColor))
           ),
           14.verticalSpacingRadius,
           Container(
             padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 30.r),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(30.r),
               color: AppColor.lightColor,
             ),
             child: Column(
               children: [
                 Obx(
                       () => Tile(
                     title: 'Name'.tr,
                     message: ProfileController.to.user.value.nama,
                     onTap: ProfileController.to.openUpdateNameDialog,
                         color: AppColor.lightColor,
                   ),
                 ),
                 Divider(height: 5.r),
                 Obx(
                       () => Tile(
                         color: AppColor.lightColor,
                     title: 'Birth date'.tr,
                     message:
                     ProfileController.to.user.value.tgl_lahir != null
                         ? DateFormat('dd/MM/yyyy').format(
                         ProfileController.to.user.value.tgl_lahir!)
                         : '-',
                     onTap: ProfileController.to.openUpdateBirthDateDialog,
                   ),
                 ),
                 Obx(
                       () => Tile(
                         color: AppColor.lightColor,
                     title: 'Phone number'.tr,
                     message: ProfileController.to.user.value.telepon ?? '-',
                     onTap: ProfileController.to.openUpdatePhoneDialog,
                   ),
                 ),
                 Divider(height: 5.r),
                 Obx(
                       () => Tile(
                     title: 'Email'.tr,
                         color: AppColor.lightColor,
                     message: ProfileController.to.user.value.email,
                     onTap: ProfileController.to.openUpdateEmailDialog,
                   ),
                 ),
                 Divider(height: 5.r),
                 Obx(
                       () => Tile(
                     title: 'Change PIN'.tr,
                         color: AppColor.lightColor,
                     message:
                     ProfileController.to.user.value.pin.toObscure(),
                     onTap: ProfileController.to.openUpdatePINDialog,
                   ),
                 ),
                 Divider(height: 5.r),
                 Obx(
                       () => Tile(
                         color: AppColor.lightColor,
                     title: 'Change language'.tr,
                     message: ProfileController.to.currentLanguage.value,
                     onTap: ProfileController.to.openLanguageDialog,
                   ),
                 ),

               ],
             ),
           ),
           ///penilian
            14.verticalSpacingRadius,
           Container(
             padding: EdgeInsets.symmetric(horizontal: 20.r,vertical: 16.r),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(30.r),
               color: AppColor.lightColor,
             ),
             child: Row(
               children: [
                 SvgPicture.asset(AssetCons.reviewIcon),
                 8.horizontalSpaceRadius,
                 Text('Review'.tr, style: Get.textTheme.titleSmall),
                 const Spacer(),
                 PrimaryButton.compact(
                   text: 'Review Now'.tr,
                   onPressed: () {},
                 ),
               ],
             ),
           ),
           14.verticalSpacingRadius,
           Padding(
             padding: EdgeInsets.only(left: 20.r),
             child: Text(
               'More Info'.tr,
               style: Get.textTheme.titleMedium!
                   .copyWith(color: AppColor.blueColor),
             ),
           ),
           14.verticalSpacingRadius,
           Container(
             padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 30.r),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(30.r),
               color: AppColor.lightColor,
             ),
             child: Column(
               children: [
                 Obx(
                       () => Tile(
                         color: AppColor.lightColor,
                     title: 'Device info'.tr,
                     message: ProfileController.to.deviceInfo.value,
                   ),
                 ),
                 Divider(height: 5.r),
                 Tile(
                   color: AppColor.lightColor,
                   title: 'Version'.tr,
                   message: AppConstant.appVersion,
                 ),
               ],
             ),
           ),
           32.verticalSpacingRadius,
           Center(
             child: SizedBox(
                 width: 204,
                 child: PrimaryButton(
                   text: 'Log Out'.tr,
                   onPressed: ProfileController.to.logout,)
             ),
           ),
         ],
       )
     ),
   ),
    );
  }
}

