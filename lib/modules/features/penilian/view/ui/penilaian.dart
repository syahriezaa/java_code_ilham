import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';

class PenilaianView extends StatelessWidget {
  const PenilaianView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.chevron_left,color:Colors.black,size:32.w),
          onPressed:()=> Get.back(),
        ),
        centerTitle: true,
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("Rate ".tr,
                style:
                Theme.of(context)
                    .textTheme
                    .titleMedium
            ),
          ],
        ),
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom:Radius.circular(30.w),
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetCons.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:20.h),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.13,
                  decoration: BoxDecoration(
                    color: AppColor.lightColor,
                    borderRadius: BorderRadius.circular(10.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 1,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left:20.w,top:20.h),
                        child: Text("Rate !".tr,
                            style:
                            Theme.of(context)
                                .textTheme
                                .titleMedium
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              20.horizontalSpace,
                              SvgPicture.asset(AssetCons.activeStar,
                                color: Colors.yellow,
                                height: 20.h,
                                width: 20.w,
                              ),
                              10.horizontalSpace,
                              SvgPicture.asset(AssetCons.activeStar,
                                color: Colors.yellow,
                                height: 20.h,
                                width: 20.w,
                              ),
                              10.horizontalSpace,
                              SvgPicture.asset(AssetCons.activeStar,
                                color: Colors.yellow,
                                height: 20.h,
                                width: 20.w,
                              ),
                              10.horizontalSpace,
                              SvgPicture.asset(AssetCons.activeStar,
                                color: Colors.yellow,
                                height: 20.h,
                                width: 20.w,
                              ),
                              10.horizontalSpace,
                              SvgPicture.asset(AssetCons.inactiveStar,
                                color: Colors.yellow,
                                height: 20.h,
                                width: 20.w,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right:20.w),
                              child: Text(
                                "Hampir Sempurna".tr,
                                style:Get
                                    .textTheme
                                    .bodyText1!
                                      .copyWith(color:AppColor.greyColor,fontSize: 12.sp)
                              ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
