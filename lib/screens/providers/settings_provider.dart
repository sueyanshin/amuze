import 'package:amuze_app/repository/settings_repository.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  final SettingsRepository _settingsRepository;

  SettingsProvider(this._settingsRepository) {
    _initializeSettings();
  }
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = Locale('en');

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  // load on startup
  Future<void> _initializeSettings() async {
    _themeMode = await _settingsRepository.loadThemeMode();
    // _locale = await _settingsRepository.loadLocale();
    notifyListeners();
  }

  // update theme mode
  Future<void> updateThemeMode(ThemeMode newMode) async {
    if (_themeMode == newMode) return;
    _themeMode = newMode;
    notifyListeners();
    await _settingsRepository.saveThemeMode(_themeMode);
  }

  // update locale
  Future<void> updateLocale(Locale newLocale) async {
    if (_locale == newLocale) return;
    _locale = newLocale;
    notifyListeners();
    await _settingsRepository.saveLocale(newLocale);
  }
}
