import 'package:core/Services/ThemeStorageService.dart';
import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  final ThemeStorageService _storageService;

  ThemeMode themeMode = ThemeMode.system;

  ThemeController(this._storageService);

  // Verifica se o tema atual é dark
  bool get isDark => themeMode == ThemeMode.dark;

  // Carrega o tema salvo quando o app abre
  Future<void> loadTheme() async {
    final isDarkSaved = await _storageService.isDarkMode();
    themeMode = isDarkSaved ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Avisa o app para se redesenhar
  }

  // Troca o tema e salva no SharedPreferences
  Future<void> toggleTheme() async {
    final isCurrentlyDark = themeMode == ThemeMode.dark;

    // Inverte o tema
    themeMode = isCurrentlyDark ? ThemeMode.light : ThemeMode.dark;

    // Salva no armazenamento local
    await _storageService.saveThemeMode(!isCurrentlyDark);

    // Avisa todos os Widgets que estão escutando para atualizar a UI
    notifyListeners();
  }
}
