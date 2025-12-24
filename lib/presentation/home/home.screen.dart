import 'package:boozin_fitness/gen/assets.gen.dart';
import 'package:boozin_fitness/infrastructure/theme/theme_utils.dart';
import 'package:boozin_fitness/presentation/home/widgets/error_banner.dart';
import 'package:boozin_fitness/presentation/home/widgets/metric_card.dart'
    show MetricCard;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ext = context.ext;
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final brightness = Theme.of(context).brightness;

    final kCalPath = brightness == Brightness.dark
        ? Assets.icons.lightKcal.path
        : Assets.icons.darkKcal.path;

    final footStepPath = brightness == Brightness.dark
        ? Assets.icons.lightFootstep.path
        : Assets.icons.darkFootstep.path;

    return Scaffold(
      backgroundColor: ext.homeBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            final isLoading = controller.isLoading.value;
            final err = controller.error.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: isLoading
                      ? const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: LinearProgressIndicator(),
                        )
                      : const SizedBox(height: 10),
                ),

                Text(
                  'Hi!',
                  style: tt.headlineMedium?.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),

                if (err != null) ...[
                  const SizedBox(height: 12),
                  ErrorBanner(
                    message: err,
                    onRetry: controller.refreshHealth,
                    onClose: controller.clearError,
                  ),
                ],

                const SizedBox(height: 34),

                MetricCard(
                  label: 'Steps:',
                  valueText: controller.steps.value.toString(),
                  progress: controller.stepsProgress,
                  leftFooterText: '0',
                  rightFooterText: 'Goal: ${controller.stepsGoal}',
                  trailingIcon: Image.asset(footStepPath, fit: BoxFit.contain),
                ),
                const SizedBox(height: 32),
                MetricCard(
                  label: 'Calories Burned:',
                  valueText: controller.kcal.value.toStringAsFixed(0),
                  progress: controller.kcalProgress,
                  leftFooterText: '0',
                  rightFooterText: 'Goal: ${controller.kcalGoal}',
                  trailingIcon: Image.asset(kCalPath, fit: BoxFit.contain),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: controller.refreshHealth,
                    child: const Text('Refresh'),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            );
          }),
        ),
      ),
    );
  }
}
