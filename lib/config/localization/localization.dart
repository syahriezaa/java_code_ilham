import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang/config/localization/lang/en_us.dart';
import 'package:magang/config/localization/lang/id_id.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';

/// Class localization
class Localization extends Translations {
  /// Mengatur default locale
  static const locale = Locale('id', 'ID');

  /// Mengatur fallback locale
  static const fallbackLocale = Locale('en', 'US');

  /// Daftar bahasa yang didukung
  static const langs = [
    'English',
    'Indonesia',
  ];

  /// Daftar path asset dari bahasa yang didukung
  static const flags = [
    AssetCons.enFlag,
    AssetCons.idFlag,
  ];

  static const locales = [
    Locale('en', 'US'),
    Locale('id', 'ID'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': translations_en_us,
        'id_ID': translations_id_ID,
      };

  static void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  static Locale getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return currentLocale;
  }

  static Locale get currentLocale {
    return Get.locale ?? fallbackLocale;
  }

  static String get currentLanguage {
    return langs.elementAt(locales.indexOf(currentLocale));
  }
}
