import 'package:flutter/foundation.dart';
import 'package:flutter_onboarding_bloc/features/profile/models/user_profile.dart';
import 'package:flutter_onboarding_bloc/features/profile/services/fake_profile_api.dart';

/// Holds the profile form state for the Profile feature.
///
/// Note: unlike the onboarding flow (which uses `flutter_bloc`), this feature
/// is built with `ChangeNotifier` + `provider`.
class ProfileProvider extends ChangeNotifier {
  ProfileProvider(this._api);

  final FakeProfileApi _api;

  UserProfile profile = UserProfile.empty();
  bool isLoading = false;

  Future<void> loadProfile() async {
    isLoading = true;
    notifyListeners();

    try {
      profile = await _api.fetchProfile();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Failed to load profile: $e');
    }
  }

  Future<bool> saveProfile(UserProfile updated) async {
    isLoading = true;
    notifyListeners();

    try {
      await _api.saveProfile(updated);
      profile = updated;
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Failed to save profile: $e');
      return false;
    }
  }
}
