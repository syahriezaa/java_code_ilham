import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../config/themes/colors.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;

  const SearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      decoration: BoxDecoration(
        border: Border.all(color: blueColor),
        borderRadius: BorderRadius.circular(30.w),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: blueColor, size: 26),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              autofocus: false,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration.collapsed(
                hintText: 'Search'.tr,
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: const Color(0xFFAAAAAA),
                ),
              ),
              textInputAction: TextInputAction.search,
            ),
          ),
        ],
      ),
    );
  }
}
