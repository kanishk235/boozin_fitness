import 'package:boozin_fitness/config/theme/app_theme.dart';
import 'package:boozin_fitness/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: SplashScreen(
        onFinished: () {
          //TODO(Kanishk): will add navigation later..
        },
      ),
    );
  }
}
