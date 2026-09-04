import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_onboarding_bloc/features/profile/models/user_profile.dart';
import 'package:flutter_onboarding_bloc/features/profile/services/fake_profile_api.dart';

void main() {
  group('FakeProfileApi', () {
    test('fetchProfile returns an empty profile by default', () async {
      final api = FakeProfileApi();

      final profile = await api.fetchProfile();

      expect(profile.username, isEmpty);
    });

    test('saveProfile persists the profile for subsequent fetches', () async {
      final api = FakeProfileApi();
      final profile = UserProfile(
        username: 'dlenam',
        birthDate: DateTime(1990, 1, 1),
        sex: 'Prefer not to say',
      );

      await api.saveProfile(profile);
      final fetched = await api.fetchProfile();

      expect(fetched.username, 'dlenam');
    });

    test('saveProfile throws when the username is empty', () async {
      final api = FakeProfileApi();
      final profile = UserProfile(username: '', birthDate: null, sex: 'Other');

      expect(() => api.saveProfile(profile), throwsException);
    });
  });
}
