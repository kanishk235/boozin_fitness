class Routes {
  static const SPLASH = '/splash';
  static const HOME = '/home';

  static Future<String> get initialRoute async {
    return SPLASH;
  }
}