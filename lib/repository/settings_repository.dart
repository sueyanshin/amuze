import 'package:amuze_app/service/settings_service.dart';
import 'package:flutter/material.dart';

class SettingsRepository {
  final SettingsService _settingsService;

  new(this._settingsService);

  Future<ThemeMode> loadThemeMode() async {
    final mode = await _settingsService.getThemeMode();
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> saveThemeMode(ThemeMode themeMode) async {
    await _settingsService.saveThemeMode(themeMode.name);
  }

  // Future<Locale> loadLocale() async {
  //   final code = await _settingsService.getLocaleCode();
  //   return Locale(code ?? 'en');
  // }

  // Future<void> saveLocale(Locale locale) async {
  //   await _settingsService.saveLocaleCode(locale.languageCode);
  // }
}
