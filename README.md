# Flutter Onboarding with BLoC

A clean, minimal example demonstrating how to build an onboarding flow in Flutter using **BLoC (`flutter_bloc`)**, **PageView**, and **SharedPreferences**.

## Features

- **BLoC State Management**: Clean separation of events (`OnboardingPageChanged`, `OnboardingCompleted`) and immutable state (`OnboardingState`).
- **Smooth PageView Navigation**: Swiping, animated Next button, and a Skip button that moves directly to the last page.
- **Dynamic Controls**: Skip button is hidden on the last page; Next button transitions into "Get Started".
- **State Persistence**: Uses `shared_preferences` through an `OnboardingRepository` to persist completion status and skip onboarding on subsequent app launches.
- **Reset Capability**: Demo Home screen includes a "Reset Onboarding" button to test the flow again.
- **Fallback Icons**: Clean UI presentation with icons if image assets are not supplied.

## Project Structure

```
lib/
├── features/
│   ├── home/
│   │   └── views/
│   │       └── home_screen.dart
│   └── onboarding/
│       ├── bloc/
│       │   ├── onboarding_bloc.dart
│       │   ├── onboarding_event.dart
│       │   └── onboarding_state.dart
│       ├── models/
│       │   └── onboarding_page_data.dart
│       ├── repository/
│       │   └── onboarding_repository.dart
│       └── views/
│           ├── onboarding_screen.dart
│           └── widgets/
│               └── onboarding_page.dart
└── main.dart
```

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/flutter_onboarding_bloc.git
   cd flutter_onboarding_bloc
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```
