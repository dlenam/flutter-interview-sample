import 'package:shared_preferences/shared_preferences.dart';

class OnboardingRepository {
  const OnboardingRepository(this._prefs);

  static const _kCompleted = 'onboarding_completed';

  final SharedPreferences _prefs;

  bool get isCompleted => _prefs.getBool(_kCompleted) ?? false;

  Future<void> complete() => _prefs.setBool(_kCompleted, true);

  Future<void> reset() => _prefs.remove(_kCompleted);
}
