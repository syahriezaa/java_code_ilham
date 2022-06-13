import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:magang/modules/models/discount_model.dart';
import 'package:magang/shared/widgets/primary_button.dart';
import 'package:magang/utils/extensions/string_case_extension.dart';

class DiskonDetailView extends StatelessWidget {
  final List<Diskon> discounts;
  const DiskonDetailView({Key? key,required this.discounts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Info discount'.tr,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 30.h),
          ...discounts.map<Widget>(
                (discount) => Padding(
              padding: EdgeInsets.only(bottom: 7.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      discount.nama.toTitleCase(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Text(
                    '${discount.nominal}%',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30.h),
          SizedBox(
            width: 168.w,
            child: PrimaryButton(
              text: 'Okay'.tr,
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }
}
