import 'package:flutter/material.dart';
import 'app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations? get _l10n => AppLocalizations.of(this);

  // Quick access to common translations with null safety
  String? get appName => _l10n?.appName; 
  String? get switchgroup => _l10n?.switchgroup;



  String? translate(String key) => _l10n?.translate(key);

  // Safe method to get translation with fallback
  String translateSafe(String key, {String? fallback}) {
    return _l10n?.translate(key) ?? fallback ?? key;
  }

  // Helper methods with fallbacks - FIXED
  String get appNameSafe => appName ?? 'App';
 
}
