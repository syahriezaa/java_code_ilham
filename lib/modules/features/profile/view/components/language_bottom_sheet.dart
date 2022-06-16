import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:magang/config/localization/localization.dart';
import 'package:magang/modules/features/menu/view/components/holder_bottom_sheet.dart';
import 'package:magang/modules/features/profile/view/components/locale_card.dart';
import 'package:magang/utils/extensions/list_extensions.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  Rx<Locale> selectedLocale = Rx<Locale>(Localization.currentLocale);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.r, vertical: 19.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HolderBottomSheet(),
          13.verticalSpacingRadius,
          Text('Change language'.tr, style: Get.textTheme.headlineSmall),
          16.verticalSpacingRadius,
          Wrap(
            spacing: 12.r,
            runSpacing: 12.r,
            children: Localization.langs
                .mapIndexed<LocaleCard>(
                  (lang, i) => LocaleCard(
                    isSelected: selectedLocale.value == Localization.locales[i],
                    flag: Localization.flags[i],
                    language: Localization.langs[i],
                    onTap: () {
                      selectedLocale.value = Localization.locales[i];
                      Get.back(result: Localization.langs[i]);
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
