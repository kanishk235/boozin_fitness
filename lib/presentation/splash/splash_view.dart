import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/splash_controller.dart';
import 'package:flutter/services.dart';

import '../../infrastructure/theme/theme_utils.dart';
import '../../gen/assets.gen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  late final Animation<double> _pinOpacity;
  late final Animation<double> _logoOpacity;
  late final Animation<Offset> _logoSlide;
  late final Animation<double> _fitnessOpacity;

  final controller = Get.find<SplashController>();

  @override
  void initState() {
    super.initState();

    _c = AnimationController(vsync: this, duration: controller.duration);

    _pinOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.10, 0.55, curve: Curves.easeOut),
      ),
    );

    _logoOpacity = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.22, 0.70, curve: Curves.easeOut),
    );

    _logoSlide = Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: const Interval(0.22, 0.70, curve: Curves.easeOut),
          ),
        );

    _fitnessOpacity = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.72, 0.95, curve: Curves.easeOut),
    );

    _c.forward().whenComplete(controller.onFinished);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final bg = context.ext.homeBg;

    final overlay = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    final logoPath = brightness != Brightness.dark
        ? Assets.logo.lightBoozinLogo.path
        : Assets.logo.darkBoozinLogo.path;

    const gap = 14.0;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlay,
      child: Scaffold(
        backgroundColor: bg,
        body: AnimatedBuilder(
          animation: _c,
          builder: (_, __) {
            return Align(
              alignment: const Alignment(0, -0.05),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: _pinOpacity.value,
                        child: Image.asset(Assets.logo.pinLogo.path),
                      ),
                      FadeTransition(
                        opacity: _logoOpacity,
                        child: SlideTransition(
                          position: _logoSlide,
                          child: Image.asset(logoPath),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: gap),
                  FadeTransition(
                    opacity: _fitnessOpacity,
                    child: Text(
                      'Fitness',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
