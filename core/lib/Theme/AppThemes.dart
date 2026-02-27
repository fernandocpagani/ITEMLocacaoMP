import 'package:flutter/material.dart';

class AppThemes {
  // 1. Declarando suas cores personalizadas
  static const Color primaryColor = Color(0xFF10B981); // Emerald/Green padrão do Tailwind
  static const Color backgroundColor = Color(0xFF314158); // Azul escuro acinzentado
  static const Color corBranca = Color(0xFFF0FDF4); // Branco esverdeado

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // 2. Aplicando a cor primária no tema claro
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor, // Força o Flutter a usar exatamente este tom de verde
      brightness: Brightness.light,
    ),

    // 3. Aplicando a cor de fundo do tema claro
    scaffoldBackgroundColor: corBranca,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: backgroundColor, // Texto da AppBar mais escuro
      centerTitle: true,
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 16),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor, // Botões verdes
        foregroundColor: corBranca, // Texto do botão
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // 4. Aplicando a cor primária no tema escuro
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, primary: primaryColor, brightness: Brightness.dark),

    // 5. Aplicando a cor de fundo do tema escuro
    scaffoldBackgroundColor: backgroundColor,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: corBranca, // Texto da AppBar claro
      centerTitle: true,
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 16),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor, // Mantém os botões verdes no dark mode
        foregroundColor: corBranca,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
