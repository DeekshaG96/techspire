import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors
  static const Color cream = Color(0xFFFDFBF7);
  static const Color sageGreen = Color(0xFF9CBFA7);
  static const Color sageGreenLight = Color(0xFFE8F0EA);
  static const Color pastelLavender = Color(0xFFE0CBE6);
  static const Color pastelLavenderLight = Color(0xFFF4EEF6);
  static const Color textDark = Color(0xFF373F41);
  static const Color textMuted = Color(0xFF828B8E);
  static const Color dangerSoft = Color(0xFFFFB3B3);
  static const Color danger = Color(0xFFD32F2F);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: cream,
      fontFamily: 'Inter',
      colorScheme: ColorScheme.light(
        primary: sageGreen,
        secondary: pastelLavender,
        surface: cream,
        error: danger,
        onPrimary: Colors.white,
        onSecondary: textDark,
        onSurface: textDark,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: textDark, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(color: textDark, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: textDark, fontSize: 16),
        bodyMedium: TextStyle(color: textMuted, fontSize: 14),
      ),
    );
  }
}
