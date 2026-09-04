class UserProfile {
  UserProfile({
    required this.username,
    required this.birthDate,
    required this.sex,
    this.avatarIndex = 0,
  });

  factory UserProfile.empty() => UserProfile(
        username: '',
        birthDate: null,
        sex: 'Prefer not to say',
        avatarIndex: 0,
      );

  String username;
  DateTime? birthDate;
  String sex;
  int avatarIndex;

  UserProfile copyWith({
    String? username,
    DateTime? birthDate,
    String? sex,
    int? avatarIndex,
  }) {
    return UserProfile(
      username: username ?? this.username,
      birthDate: birthDate ?? this.birthDate,
      sex: sex ?? this.sex,
      avatarIndex: avatarIndex ?? this.avatarIndex,
    );
  }
}
