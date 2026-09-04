import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_onboarding_bloc/features/profile/models/user_profile.dart';

void main() {
  group('UserProfile', () {
    test('copyWith overrides only the provided fields', () {
      final original = UserProfile(
        username: 'dlenam',
        birthDate: DateTime(1990, 1, 1),
        sex: 'Prefer not to say',
        avatarIndex: 2,
      );

      final updated = original.copyWith(username: 'daniel');

      expect(updated.username, 'daniel');
      expect(updated.birthDate, original.birthDate);
      expect(updated.sex, original.sex);
      expect(updated.avatarIndex, original.avatarIndex);
    });

    test('UserProfile.empty starts with no username and no birth date', () {
      final empty = UserProfile.empty();

      expect(empty.username, isEmpty);
      expect(empty.birthDate, isNull);
    });
  });
}
