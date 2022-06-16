import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/modules/features/menu/controllers/menu_controller.dart';
import 'package:magang/modules/features/menu/view/components/holder_bottom_sheet.dart';


class NoteBottomSheet extends StatelessWidget {
  final TextEditingController noteController =
  TextEditingController(text: MenuController.to.note.value);

  NoteBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 19.h),
      child: Wrap(
        children: [
          const HolderBottomSheet(),
          SizedBox(height: 13.h),
          Text(
            'Create Note'.tr,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 13.h),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: noteController,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                    hintText: 'Add note'.tr,
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: blueColor, width: 2),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: blueColor, width: 2),
                    ),
                  ),
                  maxLength: 100,
                ),
              ),
              SizedBox(height: 12.w),
              IconButton(
                icon: const Icon(Icons.check_circle),
                splashRadius: 20.r,
                color: blueColor,
                onPressed: () {
                  MenuController.to.setNote(noteController.text);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
