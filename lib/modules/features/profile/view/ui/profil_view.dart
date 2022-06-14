import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magang/config/themes/light_theme.dart';
import 'package:magang/constant/common/constants.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';
import 'package:magang/modules/features/profile/controller/profile_controller.dart';
import 'package:magang/shared/widgets/primary_button.dart';

import '../../../../../config/themes/colors.dart';
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
           Center(
               child: SizedBox(
                   width: 204,
                   child: PrimaryButton(
                     text: 'Log out'.tr,
                     onPressed: ProfileController.to.logout,)
               )
           )

         ],
       )
     ),
   ),
    );
  }
}

