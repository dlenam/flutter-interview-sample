import 'package:flutter_onboarding_bloc/features/profile/models/user_profile.dart';

/// Simulates a backend for the profile feature since no real API exists yet.
///
/// Data only lives in memory for as long as the app process is alive - it is
/// not written to disk, so it will not survive an app restart.
class FakeProfileApi {
  static UserProfile _storedProfile = UserProfile.empty();

  Future<UserProfile> fetchProfile() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _storedProfile;
  }

  Future<void> saveProfile(UserProfile profile) async {
    await Future.delayed(const Duration(milliseconds: 600));

    if (profile.username.trim().isEmpty) {
      throw Exception('Username cannot be empty');
    }

    _storedProfile = profile;
  }
}
