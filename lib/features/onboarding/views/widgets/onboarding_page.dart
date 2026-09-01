import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String? description;
  final String? imagePath;
  final IconData? icon;
  final String? badge;
  final Color? accentColor;

  const OnboardingPage({
    super.key,
    required this.title,
    this.description,
    this.imagePath,
    this.icon,
    this.badge,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryColor = accentColor ?? colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 1),

          // Illustration / Image Container
          Expanded(
            flex: 6,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 340, maxHeight: 340),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor.withValues(alpha: 0.12),
                      primaryColor.withValues(alpha: 0.04),
                    ],
                  ),
                  border: Border.all(
                    color: primaryColor.withValues(alpha: 0.15),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.08),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Subtle background decorative circles
                      Positioned(
                        top: -30,
                        right: -30,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor.withValues(alpha: 0.1),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -40,
                        left: -20,
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor.withValues(alpha: 0.08),
                          ),
                        ),
                      ),

                      // Main Content: Image with fallback to Icon
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: _buildIllustration(primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Optional Badge / Category Tag
          if (badge != null && badge!.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                badge!,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              color: colorScheme.onSurface,
            ),
          ),

          // Description / Subtitle
          if (description != null && description!.isNotEmpty) ...[
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.45,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ],

          const Spacer(flex: 1),
        ],
      ),
    );
  }

  Widget _buildIllustration(Color primaryColor) {
    if (imagePath != null && imagePath!.isNotEmpty) {
      return Image.asset(
        imagePath!,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackIcon(primaryColor);
        },
      );
    }
    return _buildFallbackIcon(primaryColor);
  }

  Widget _buildFallbackIcon(Color primaryColor) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        icon ?? Icons.auto_awesome_rounded,
        size: 54,
        color: primaryColor,
      ),
    );
  }
}
