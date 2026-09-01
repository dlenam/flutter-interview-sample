import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:flutter_onboarding_bloc/features/home/views/home_screen.dart';
import 'package:flutter_onboarding_bloc/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter_onboarding_bloc/features/onboarding/models/onboarding_page_data.dart';
import 'package:flutter_onboarding_bloc/features/onboarding/repository/onboarding_repository.dart';
import 'package:flutter_onboarding_bloc/features/onboarding/views/widgets/onboarding_page.dart';

const _kPages = <OnboardingPageData>[
  OnboardingPageData(
    badge: 'DISCOVER',
    title: 'Welcome to App',
    description:
        'Explore powerful tools and features designed to make your daily workflow fast and seamless.',
    icon: Icons.explore_rounded,
    imagePath: 'assets/step1.png',
  ),
  OnboardingPageData(
    badge: 'INSIGHTS',
    title: 'Track Your Progress',
    description:
        'Stay on top of your goals with intuitive real-time metrics and in-depth performance analytics.',
    icon: Icons.insights_rounded,
    imagePath: 'assets/step2.png',
  ),
  OnboardingPageData(
    badge: 'COLLABORATE',
    title: 'Work Together',
    description:
        'Invite your team, share projects, and accomplish more with real-time collaboration tools.',
    icon: Icons.group_rounded,
    imagePath: 'assets/step3.png',
  ),
  OnboardingPageData(
    badge: 'SECURE',
    title: 'Your Data is Safe',
    description:
        'End-to-end encryption and enterprise-grade security keep all your data private and protected.',
    icon: Icons.shield_rounded,
    imagePath: 'assets/step4.png',
  ),
  OnboardingPageData(
    badge: 'CUSTOMIZE',
    title: 'Make It Yours',
    description:
        'Personalize themes, layouts, and notifications so the app fits exactly how you like to work.',
    icon: Icons.tune_rounded,
    imagePath: 'assets/step5.png',
  ),
  OnboardingPageData(
    badge: 'READY',
    title: "All Set — Let's Go!",
    description:
        'Join our growing community and unlock the full potential of your productivity journey.',
    icon: Icons.rocket_launch_rounded,
    imagePath: 'assets/step6.png',
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  late final OnboardingBloc _bloc;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _bloc = OnboardingBloc(
      totalPages: _kPages.length,
      repository: context.read<OnboardingRepository>(),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _bloc.close();
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
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
      body: BlocProvider.value(
        value: _bloc,
        child: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  if (!state.isLastPage)
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () => _pageController.animateToPage(
                          _kPages.length - 1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        ),
                        child: const Text('Skip'),
                      ),
                    )
                  else
                    const SizedBox(height: 48),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) =>
                          _bloc.add(OnboardingPageChanged(index)),
                      children: [
                        for (final page in _kPages)
                          OnboardingPage(
                            badge: page.badge,
                            title: page.title,
                            description: page.description,
                            imagePath: page.imagePath,
                            icon: page.icon,
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: _kPages.length,
                          effect: WormEffect(
                            activeDotColor: theme.colorScheme.primary,
                            dotColor: theme.colorScheme.primary.withValues(
                              alpha: 0.2,
                            ),
                            dotHeight: 10,
                            dotWidth: 10,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (state.isLastPage) {
                              _bloc.add(OnboardingCompleted());
                              _navigateToHome();
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Text(
                            state.isLastPage ? 'Get Started' : 'Next',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
