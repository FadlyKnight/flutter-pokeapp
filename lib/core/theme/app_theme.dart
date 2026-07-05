import 'package:flutter/material.dart';

/// Material 3 light/dark themes shared across the app.
class AppTheme {
  const AppTheme._();

  static const Color _seed = Color(0xFFEE1515);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.light),
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
        cardTheme: const CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
        appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark),
        fontFamily: 'Poppins',
        cardTheme: const CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
        appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
      );
}
