import 'package:boozin_fitness/infrastructure/theme/theme_utils.dart';
import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.label,
    required this.valueText,
    required this.progress,
    required this.leftFooterText,
    required this.rightFooterText,
    required this.trailingIcon,

    this.height = 122,
    this.borderRadius = 24,
    this.iconSize = 52,
  });

  final String label;
  final String valueText;
  final double progress;
  final String leftFooterText;
  final String rightFooterText;
  final Widget trailingIcon;
  final double height;
  final double borderRadius;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final ext = context.ext;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final tt = Theme.of(context).textTheme;

    final p = progress.clamp(0.0, 1.0);

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ext.cardBg,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 18, bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: tt.titleMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      valueText,
                      style: tt.titleMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: onSurface,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: SizedBox(
                    height: 16,
                    child: LayoutBuilder(
                      builder: (_, c) {
                        final w = c.maxWidth;
                        return Stack(
                          children: [
                            Positioned.fill(
                              child: ColoredBox(color: ext.progressTrack),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              bottom: 0,
                              width: w * p,
                              child: ColoredBox(color: ext.progressFill),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      leftFooterText,
                      style: tt.labelSmall?.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: onSurface,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      rightFooterText,
                      style: tt.labelSmall?.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: iconSize,
              height: iconSize,
              child: trailingIcon,
            ),
          ),
        ],
      ),
    );
  }
}
