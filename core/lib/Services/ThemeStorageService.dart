import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorageService {
  static const String _themeKey = 'isDarkMode';

  // Salva a preferência do usuário
  Future<void> saveThemeMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }

  // Lê a preferência salva (retorna false por padrão se for a primeira vez)
  Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false;
  }
}
