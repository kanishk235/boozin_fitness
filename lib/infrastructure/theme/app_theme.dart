import 'package:flutter/material.dart';
import 'theme_utils.dart';

final class AppTheme {
  const AppTheme._();

  static const Color seedColor = Colors.deepOrange;

  static ThemeData light() => _base(brightness: Brightness.light).copyWith(
    extensions: const [
      ExtendedColors(
        homeBg: Color(0xFFFFFFFF),
        cardBg: Color(0xFFF0F0F0),
        progressTrack: Color(0xFFC4C4C4),
        progressFill: Color(0xFF000000),
      ),
    ],
  );

  static ThemeData dark() => _base(brightness: Brightness.dark).copyWith(
    extensions: const [
      ExtendedColors(
        homeBg: Color(0xFF181818),
        cardBg: Color(0xFF323232),
        progressTrack: Color(0xFF8A8A8A),
        progressFill: Color(0xFFFFFFFF),
      ),
    ],
  );

  static ThemeData _base({required Brightness brightness}) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: brightness,
      scaffoldBackgroundColor: scheme.surface,
    );
  }
}
