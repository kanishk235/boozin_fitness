import 'package:get/get.dart';
import '../../../infrastructure/health/health_service.dart';

class HomeController extends GetxController {
  HomeController({HealthService? healthService})
      : _health = healthService ?? HealthService();

  final HealthService _health;

  final isLoading = true.obs;
  final error = RxnString();

  final steps = 0.obs;
  final kcal = 0.0.obs;

  final stepsGoal = 15000;
  final kcalGoal = 1000;

  double get stepsProgress =>
      stepsGoal == 0 ? 0 : (steps.value / stepsGoal).clamp(0.0, 1.0);

  double get kcalProgress =>
      kcalGoal == 0 ? 0 : (kcal.value / kcalGoal).clamp(0.0, 1.0);

  @override
  void onReady() {
    super.onReady();
    refreshHealth();
  }

  void clearError() => error.value = null;


  Future<void> refreshHealth() async {
    try {
      isLoading.value = true;
      error.value = null;

      await _health.configure();

      final ready = await _health.ensureHealthConnectReady();
      if (!ready) {
        error.value = 'Health Connect required. Please install and retry.';
        return;
      }

      final ok = await _health.requestStepsAndCaloriesPermission();
      if (!ok) {
        error.value = 'Permission denied. Enable permissions in Health Connect.';
        return;
      }

      final data = await _health.fetchTodayStepsAndKcal();
      steps.value = data.steps;
      kcal.value = data.kcal;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

