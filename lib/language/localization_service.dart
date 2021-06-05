import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/language/language_en.dart';
import 'package:project/language/language_tr.dart';

class LocalizationService extends Translations {
  static final local = Locale('en', 'US');
  static final fallBackLocale = Locale('en', 'US');

  static final langs = ['English', 'Turkish'];
  static final locales = [Locale('en', 'US'), Locale('tr', 'TR')];

  Map<String, Map<String, String>> get keys => {
        'tr_TR': trTR,
        'en_US': enUS,
      };

  void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  Locale getLocaleFromLanguage(String lang) {
    for (int i = 0; i < lang.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
