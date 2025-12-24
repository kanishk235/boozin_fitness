import 'package:boozin_fitness/gen/assets.gen.dart';
import 'package:boozin_fitness/infrastructure/theme/theme_utils.dart';
import 'package:boozin_fitness/presentation/home/widgets/metric_card.dart'
    show MetricCard;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final overlay = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    final bg = context.ext.homeBg;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlay,
      child: Scaffold(
        backgroundColor: bg,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Text(
                  'Hi!',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                    height: 44 / 32,
                  ),
                ),
                const SizedBox(height: 40),
                MetricCard(
                  label: 'Steps:',
                  valueText: '13,112',
                  progress: 13112 / 15000,
                  leftFooterText: '0',
                  rightFooterText: 'Goal: 15,000',
                  trailingIcon: Image.asset(
                    Assets.icons.footstep.path,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 32),

                MetricCard(
                  label: 'Calories Burned:',
                  valueText: '500',
                  progress: 500 / 1000,
                  leftFooterText: '0',
                  rightFooterText: 'Goal: 1000',
                  trailingIcon: Image.asset(
                    Assets.icons.kcal.path,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
