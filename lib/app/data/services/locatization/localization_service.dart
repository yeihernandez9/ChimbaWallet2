import 'package:chimba_wallet/app/core/values/languages/es-en.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationService extends Translations {
  static final locale = Locale("es", "EN");
  static final fallBackLocale = Locale("es", "EN");
  static final langs = ['فارسی', 'English'];
  static final locales = [Locale("fa", "AF"), Locale("es", "EN")];

  String selectedLang = langs.first;

  @override
  Map<String, Map<String, String>> get keys => {
        'es_EN': esEN,
      };

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    selectedLang = lang;
    Get.updateLocale(locale);
  }

  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale!;
  }
}
