# Boozin Fitness — Project Summary

Boozin Fitness is a lightweight fitness dashboard app that displays **Steps** and **Calories Burned (kcal)** with a clean UI, animated splash screen, and **automatic Light/Dark theme** support.

---

## What the app does
- Shows two key metrics:
  - **Steps**
  - **Active calories burned (kcal)**
- Each metric is presented as a reusable **Metric Card**:
  - Title + value
  - Progress bar toward a goal
  - Left/Right footer labels (e.g., `0` and `Goal: ...`)
  - Trailing icon (tinted automatically based on theme)
- Provides a **Refresh** option and handles:
  - Loading state
  - Error state with Retry

---

## App Flow
1. **Splash Screen**
   - Animated logo sequence (pin → logo fade/slide → “Fitness” text)
   - Status bar adapts to current theme
   - Splash logo switches based on Light/Dark theme
2. **Home Screen**
   - “Hi!” header
   - Steps card + Calories card
   - Refresh + error/loading handling

---

## State Management & Navigation
- **GetX**
  - Reactive state (`Obx`) for steps/kcal/loading/error
  - Controllers via dependency injection (`Get.find()`)
  - Navigation via `GetMaterialApp` + route pages

---

## Architecture (high-level)
- **Feature-first structure**
  - Each feature contains its own controller/view/widgets (e.g., `presentation/splash`, `presentation/home`)
- **Separation of concerns**
  - `presentation/` → UI (screens, widgets, controllers)
  - `infrastructure/` → theme, navigation, configs

---

## Theming
- **Material 3 enabled**
- Uses `ThemeMode.system` so the UI follows device theme automatically
- Custom colors are added via **ThemeExtension**:
  - `ExtendedColors` (e.g., `homeBg`, `cardBg`, `progressTrack`, `progressFill`)
- Icons are automatically tinted using the theme’s `colorScheme.onSurface`

---

## Health Data Integration
- Uses the **`health`** plugin
- Reads:
  - Steps
  - Active calories burned (kcal)

### Android notes
- Uses **Health Connect** (not the legacy Google Fit API)
- Requires Health Connect availability and permissions:
  - `android.permission.health.READ_STEPS`
  - `android.permission.health.READ_ACTIVE_CALORIES_BURNED`
  - `android.permission.ACTIVITY_RECOGNITION`

---

## Key Packages
- `get` → state management, routing, DI
- `health` → steps & calories (Health Connect / HealthKit)
- `flutter_gen` → typed asset access (`assets.gen.dart`)
- `material` / Material 3 + ThemeExtension → theming system

---

## UI Components
- **MetricCard** (reusable widget)
  - Supports progress, labels, values, theme-based icon tinting
- **SplashView**
  - Animated pin/logo/text sequence
  - Theme-aware background and logo selection
