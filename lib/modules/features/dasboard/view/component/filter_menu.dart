import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../config/themes/colors.dart';
import '../../../../../config/themes/colors.dart';

class FilterMenu extends StatelessWidget {

  final bool isSelected;
  final String text;
  final String iconPath;
  final Function()? onTap;

  const FilterMenu({
    Key? key,
    required this.isSelected,
    required this.text,
    required this.iconPath,
    required this.onTap,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.w),
      child: Ink(
        padding:
            EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20.w)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.w),
          color: isSelected ? darkColor2 : blueColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 8,
              spreadRadius:-0.5,
              color: darkColor2.withOpacity(0.25),
            ),
          ],
          ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            SvgPicture.asset(iconPath),
                SizedBox(width: ScreenUtil().setWidth(10.w)),
            Text(
                  text,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
                ),
            ]
        ),
      ),
      );
  }
}
