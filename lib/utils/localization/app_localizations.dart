import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // All your app strings go here
  Map<String, String> get _localizedStrings {
    switch (locale.languageCode) {
      case 'mr':
        return _marathiStrings;
      case 'en':
        return _englishStrings;
      case 'hi':
        return _hindiStrings;
      default:
        return _englishStrings;
    }
  }

  // Helper method to get translated string
  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  // Convenience getters for commonly used strings
  String get appName => translate('app_name');
  String get switchgroup => translate('switch_group');

  // Weekday convenience getters
  String get monday => translate('mon');
  String get tuesday => translate('tue');
  String get wednesday => translate('wed');
  String get thursday => translate('thu');
  String get friday => translate('fri');
  String get saturday => translate('sat');
  String get sunday => translate('sun');
  // Marathi strings
  static const Map<String, String> _marathiStrings = {
    'app_name': 'माझे अॅप',
    'settings': 'सेटिंग्ज',
    'no_categories_found':'कोणत्याही श्रेण्या आढळल्या नाहीत',
  };

  // English strings
  static const Map<String, String> _englishStrings = {
    'app_name': 'My App',
   
  };

  static const Map<String, String> _hindiStrings = {
    'app_name': 'मेरा ऐप',
   
  };
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['mr', 'en', 'hi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
