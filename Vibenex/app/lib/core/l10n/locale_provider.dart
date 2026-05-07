import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('vi');
  Locale get locale => _locale;

  LocaleProvider() { _loadFromPrefs(); }

  void setLocale(Locale locale) { _locale = locale; _saveToPrefs(); notifyListeners(); }
  void toggleLocale() { _locale = _locale.languageCode == 'vi' ? const Locale('en') : const Locale('vi'); _saveToPrefs(); notifyListeners(); }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(AppConstants.localeKey);
    if (code != null) { _locale = Locale(code); notifyListeners(); }
  }
  Future<void> _saveToPrefs() async { final prefs = await SharedPreferences.getInstance(); await prefs.setString(AppConstants.localeKey, _locale.languageCode); }
}
