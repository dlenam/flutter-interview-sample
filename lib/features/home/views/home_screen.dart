import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:flutter_onboarding_bloc/features/onboarding/repository/onboarding_repository.dart';
import 'package:flutter_onboarding_bloc/features/onboarding/views/onboarding_screen.dart';
import 'package:flutter_onboarding_bloc/features/profile/providers/profile_provider.dart';
import 'package:flutter_onboarding_bloc/features/profile/services/fake_profile_api.dart';
import 'package:flutter_onboarding_bloc/features/profile/views/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openProfile(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => ProfileProvider(FakeProfileApi())..loadProfile(),
          child: const ProfileScreen(),
        ),
      ),
    );
  }

  Future<void> _resetOnboarding(BuildContext context) async {
    await context.read<OnboardingRepository>().reset();
    if (!context.mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const OnboardingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    size: 52,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "You're all set!",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Onboarding complete.\nThis is a simple demo home screen.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                ElevatedButton.icon(
                  onPressed: () => _openProfile(context),
                  icon: const Icon(Icons.person_rounded),
                  label: const Text('Edit Profile'),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () => _resetOnboarding(context),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Reset Onboarding'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
