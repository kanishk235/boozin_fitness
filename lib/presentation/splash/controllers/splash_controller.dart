import 'package:get/get.dart';
import '../../../infrastructure/navigation/routes.dart';

class SplashController extends GetxController {
  final duration = const Duration(milliseconds: 2200);

  void onFinished() {
    Get.offAllNamed(Routes.HOME);
  }
}
