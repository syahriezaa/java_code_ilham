import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magang/config/routes/app_routes.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';

class DaftarPenilaianView extends StatelessWidget {
  const DaftarPenilaianView({Key? key}) : super(key: key);

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
          Text("Ratings List".tr,
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
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(width:50.h),
            Ink(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                    color: AppColor.lightColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2,
                        spreadRadius: 1,
                      )
                    ],
                  ),
              child: InkWell(
                onTap: (){
                  Get.toNamed("/penilaian_detail");
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Column(
                        children: [
                          10.verticalSpace,
                          Row(
                            children: [
                              10.horizontalSpace,
                              SvgPicture.asset(AssetCons.reviewDate),
                              5.horizontalSpace,
                              Text("Penyajian Makanan",style: Get.textTheme.titleMedium!.copyWith(color: AppColor.blueColor)),
                              SvgPicture.asset(AssetCons.rating1),
                                ],
                          ),
                          5.verticalSpace,
                          Row(
                            children:[
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text("Penyajian kurang menarik, tidak ada timun ...",style: Get.textTheme.bodyText1!.copyWith(color: AppColor.greyColor,fontSize: 12.w)),
                              )
                            ]
                          )
                        ],
                      ),
                        IconButton(onPressed: (){
                          Get.toNamed(AppRoutes.PenilianView);
                        }, icon: Icon(Icons.reply,color: Colors.green,size: 30.w),),

                      ],
                    ),
                  ],
                ),

                ),
            ),
          ],
          ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(AppRoutes.PenilianView);
        },
        child: Icon(Icons.add,color: Colors.white,size: 30.w),
        backgroundColor: AppColor.blueColor,
      ),
    );
  }
}
