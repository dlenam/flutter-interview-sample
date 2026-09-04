import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_onboarding_bloc/features/profile/models/user_profile.dart';
import 'package:flutter_onboarding_bloc/features/profile/providers/profile_provider.dart';
import 'package:flutter_onboarding_bloc/features/profile/views/widgets/avatar_picker.dart';

const List<String> kSexOptions = [
  'Female',
  'Male',
  'Other',
  'Prefer not to say',
];

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  DateTime? _birthDate;
  String _sex = kSexOptions.last;
  int _avatarIndex = 0;
  bool _formInitialized = false;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _syncFormWithProfile(UserProfile profile) {
    if (_formInitialized) return;
    _formInitialized = true;
    _usernameController.text = profile.username;
    _birthDate = profile.birthDate;
    _sex = profile.sex;
    _avatarIndex = profile.avatarIndex;
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _birthDate = picked);
    }
  }

  Future<void> _save(ProfileProvider provider) async {
    if (!_formKey.currentState!.validate()) return;

    final updated = UserProfile(
      username: _usernameController.text.trim(),
      birthDate: _birthDate,
      sex: _sex,
      avatarIndex: _avatarIndex,
    );

    final success = await provider.saveProfile(updated);
    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    _syncFormWithProfile(provider.profile);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: AvatarPicker(
                        selectedIndex: _avatarIndex,
                        onSelected: (index) =>
                            setState(() => _avatarIndex = index),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Username is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: _pickBirthDate,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Date of birth',
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          _birthDate == null
                              ? 'Select a date'
                              : '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Sex', style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final option in kSexOptions)
                          ChoiceChip(
                            label: Text(option),
                            selected: _sex == option,
                            onSelected: (_) => setState(() => _sex = option),
                          ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            provider.isLoading ? null : () => _save(provider),
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (provider.isLoading)
              Container(
                color: Colors.black12,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
