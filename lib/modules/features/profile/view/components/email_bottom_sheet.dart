import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:magang/modules/features/menu/view/components/holder_bottom_sheet.dart';

import 'package:magang/config/themes/colors.dart';

class EmailBottomSheet extends StatefulWidget {
  final String email;
  const EmailBottomSheet({Key? key, required this.email}) : super(key: key);

  @override
  State<EmailBottomSheet> createState() => _EmailBottomSheetState();
}

class _EmailBottomSheetState extends State<EmailBottomSheet> {
  late final TextEditingController controller;
  final formKey=GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.r, vertical: 19.r),
      child: Wrap(
        children: [
          const HolderBottomSheet(),
          13.verticalSpacingRadius,
          Text('Email'.tr, style: Get.textTheme.headlineSmall),
          13.verticalSpacingRadius,
          Row(
            children: [
              Expanded(
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: controller,
                    style: Get.textTheme.bodySmall,
                    validator: (value) {
                      if (!GetUtils.isEmail(controller.text)) {
                        return 'Ivalid Email'.tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Email'.tr,
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
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
                  ),

                ),
              ),
              12.verticalSpacingRadius,
              IconButton(
                icon: const Icon(Icons.check_circle),
                splashRadius: 20.r,
                color:AppColor.blueColor,
                onPressed: ()  {
                  if(formKey.currentState!.validate()){
                    Get.back(result: controller.text);
                  }
                  },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
