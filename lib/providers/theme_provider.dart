import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This provider manages the app's theme and persists the user's choice.
class ThemeProvider with ChangeNotifier {
  // The initial value is now light, this affects the very first frame of the app.
  ThemeMode _themeMode = ThemeMode.light;
  static const String _themePreferenceKey = 'theme_preference';

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  // Load the saved theme preference from local storage.
  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    // The fallback value is now 1, which corresponds to ThemeMode.light.
    // ThemeMode.values is [system, light, dark], so light is at index 1.
    final themeIndex = prefs.getInt(_themePreferenceKey) ?? 1;
    _themeMode = ThemeMode.values[themeIndex];
    notifyListeners();
  }

  // Save the current theme preference to local storage.
  Future<void> _saveTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themePreferenceKey, themeMode.index);
  }

  // Toggle between light and dark themes.
  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _saveTheme(_themeMode);
    notifyListeners();
  }
}
