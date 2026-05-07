import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  ThemeNotifier() { _loadFromPrefs(); }

  void toggleTheme() { _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark; _saveToPrefs(); notifyListeners(); }
  void setThemeMode(ThemeMode mode) { _themeMode = mode; _saveToPrefs(); notifyListeners(); }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(AppConstants.themeModeKey);
    if (value != null) { _themeMode = ThemeMode.values.firstWhere((e) => e.name == value, orElse: () => ThemeMode.system); notifyListeners(); }
  }
  Future<void> _saveToPrefs() async { final prefs = await SharedPreferences.getInstance(); await prefs.setString(AppConstants.themeModeKey, _themeMode.name); }
}
