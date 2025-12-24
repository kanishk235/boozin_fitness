import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:health/health.dart';

class HealthService {
  HealthService({Health? health}) : _health = health ?? Health();

  final Health _health;

  Future<void> configure() => _health.configure();

  Future<bool> ensureHealthConnectReady() async {
    if (!Platform.isAndroid) return true;

    final available = await _health.isHealthConnectAvailable();
    if (!available) {
      await _health.installHealthConnect();
      return false;
    }
    return true;
  }

  Future<bool> requestStepsAndCaloriesPermission() async {
    final types = <HealthDataType>[
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ];

    final permissions = <HealthDataAccess>[
      HealthDataAccess.READ,
      HealthDataAccess.READ,
    ];

    final ok = await _health.requestAuthorization(types, permissions: permissions);
    return ok;
  }

  Future<({int steps, double kcal})> fetchTodayStepsAndKcal({
    bool includeManualEntry = true,
  }) async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = now;

    final steps = await _health.getTotalStepsInInterval(
      start,
      end,
      includeManualEntry: includeManualEntry,
    ) ??
        0;

    final points = await _health.getHealthDataFromTypes(
      types: const [HealthDataType.ACTIVE_ENERGY_BURNED],
      startTime: start,
      endTime: end,
    );

    final cleaned = _health.removeDuplicates(points);

    double kcal = 0;
    for (final p in cleaned) {
      if (p.type == HealthDataType.ACTIVE_ENERGY_BURNED) {
        final v = (p.value as NumericHealthValue).numericValue.toDouble();
        kcal += v;
      }
    }

    if (kDebugMode) {
      debugPrint('Health today -> steps=$steps, kcal=$kcal points=${cleaned.length}');
    }

    return (steps: steps, kcal: kcal);
  }
}
