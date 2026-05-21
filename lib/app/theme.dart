import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  const seed = Color(0xFF2854A3);
  const ink = Color(0xFF152238);

  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seed,
      primary: seed,
      secondary: const Color(0xFFB85C38),
      tertiary: const Color(0xFF1F8A70),
      surface: const Color(0xFFFFFCF6),
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF4EFE6),
    textTheme: Typography.blackMountainView.apply(
      bodyColor: ink,
      displayColor: ink,
      fontFamily: 'Georgia',
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: ink,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: const Color(0xFFFFFCF6),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: const BorderSide(color: Color(0x1A152238)),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFFFFCF6),
      selectedColor: const Color(0xFFE4ECFF),
      side: const BorderSide(color: Color(0x1A152238)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
      ),
      labelStyle: const TextStyle(fontWeight: FontWeight.w700),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: seed, width: 1.4),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        textStyle: const TextStyle(fontWeight: FontWeight.w800),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        side: const BorderSide(color: Color(0x662854A3)),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        textStyle: const TextStyle(fontWeight: FontWeight.w800),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
