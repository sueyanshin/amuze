import 'package:amuze_app/core/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  Future<String?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.themeKey);
  }

  Future<void> saveThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstants.themeKey, mode);
  }

  Future<String?> getLocaleCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.localeKey);
  }

  Future<void> saveLocaleCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstants.localeKey, code);
  }
}
