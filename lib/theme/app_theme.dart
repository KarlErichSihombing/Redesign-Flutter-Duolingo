import 'package:flutter/material.dart';

class AppColors {
  static const featherGreen = Color(0xFF58CC02);
  static const maskGreen = Color(0xFF89E219);
  static const eel = Color(0xFF4B4B4B);
  static const snow = Color(0xFFFFFFFF);
  static const macaw = Color(0xFF1CB0F6);
  static const cardinal = Color(0xFFFF4B4B);
  static const bee = Color(0xFFFFC800);
  static const fox = Color(0xFFFF9600);
  static const beetle = Color(0xFFCE82FF);
  static const humpback = Color(0xFF2B70C9);
  static const bg = Color(0xFFF7F7F7);
  static const border = Color(0xFFE5E5E5);
  static const textPrimary = Color(0xFF3C3C3C);
  static const textMuted = Color(0xFF777777);
}

class AppTheme {
  static ThemeData get theme => ThemeData(
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: const ColorScheme.light(
          primary: AppColors.featherGreen,
          secondary: AppColors.macaw,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.snow,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
        ),
      );
}
