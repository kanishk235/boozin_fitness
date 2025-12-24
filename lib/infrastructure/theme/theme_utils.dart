import 'package:flutter/material.dart';

@immutable
class ExtendedColors extends ThemeExtension<ExtendedColors> {
  const ExtendedColors({
    required this.homeBg,
    required this.cardBg,
    required this.progressTrack,
    required this.progressFill,
  });

  final Color homeBg;
  final Color cardBg;
  final Color progressTrack;
  final Color progressFill;

  @override
  ExtendedColors copyWith({
    Color? homeBg,
    Color? cardBg,
    Color? progressTrack,
    Color? progressFill,
  }) {
    return ExtendedColors(
      homeBg: homeBg ?? this.homeBg,
      cardBg: cardBg ?? this.cardBg,
      progressTrack: progressTrack ?? this.progressTrack,
      progressFill: progressFill ?? this.progressFill,
    );
  }

  @override
  ExtendedColors lerp(ThemeExtension<ExtendedColors>? other, double t) {
    if (other is! ExtendedColors) return this;
    return ExtendedColors(
      homeBg: Color.lerp(homeBg, other.homeBg, t) ?? homeBg,
      cardBg: Color.lerp(cardBg, other.cardBg, t) ?? cardBg,
      progressTrack:
      Color.lerp(progressTrack, other.progressTrack, t) ?? progressTrack,
      progressFill:
      Color.lerp(progressFill, other.progressFill, t) ?? progressFill,
    );
  }
}

extension ExtendedColorsX on BuildContext {
  ExtendedColors get ext =>
      Theme.of(this).extension<ExtendedColors>()!;
}
