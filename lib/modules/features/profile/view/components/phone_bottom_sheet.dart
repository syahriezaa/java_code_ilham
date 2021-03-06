import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:magang/modules/features/menu/view/components/holder_bottom_sheet.dart';
import '../../../../../config/themes/colors.dart';

class PhoneBottomSheet extends StatefulWidget {
  final String telepon;
  final TextInputType keyboardType;
  const PhoneBottomSheet({Key? key, required this.telepon,required this.keyboardType}) : super(key: key);

  @override
  State<PhoneBottomSheet> createState() => _PhoneBottomSheetState();
}

class _PhoneBottomSheetState extends State<PhoneBottomSheet> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.telepon);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.r, vertical: 19.r),
      child: Wrap(
        children: [
          const HolderBottomSheet(),
          13.verticalSpacingRadius,
          Text('Phone number'.tr, style: Get.textTheme.headlineSmall),
          13.verticalSpacingRadius,
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: widget.keyboardType,
                  controller: controller,
                  style: Get.textTheme.bodySmall,
                  decoration: InputDecoration(
                    hintText: 'Phone number'.tr,
                    hintStyle: Get.textTheme.bodySmall,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: AppColor.blueColor, width: 2),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: AppColor.blueColor, width: 2),
                    ),
                  ),
                  maxLength: 100,
                  autofocus: true,
                ),
              ),
              12.verticalSpacingRadius,
              IconButton(
                icon: const Icon(Icons.check_circle),
                splashRadius: 20.r,
                color: AppColor.blueColor,
                onPressed: () => Get.back(result: controller.text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
