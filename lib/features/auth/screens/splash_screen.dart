/// splash_screen.dart - Premium animated splash matching Figma
/// Feature: Auth

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _bgFade;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<double> _taglineFade;
  late final Animation<Offset> _taglineSlide;
  late final Animation<double> _footerFade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    // Background fades in first
    _bgFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.45, curve: Curves.easeIn),
    );

    // Logo scales up with slight bounce + fade
    _logoScale = Tween<double>(begin: 0.72, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.65, curve: Curves.easeOutBack),
      ),
    );
    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 0.55, curve: Curves.easeIn),
    );

    // Tagline slides up gently
    _taglineSlide = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.85, curve: Curves.easeOutCubic),
      ),
    );
    _taglineFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.45, 0.85, curve: Curves.easeIn),
    );

    // Footer fades last
    _footerFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 3400), () {
      if (mounted) context.go('/onboarding');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary900,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background (mountains) ──────────────────────────
          FadeTransition(
            opacity: _bgFade,
            child: Image.asset(
              'assets/images/splash background.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (_, __, ___) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF0A0E24),
                      Color(0xFF141A3A),
                      Color(0xFF1A2444),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Soft dark overlay so logo stays crisp (like Figma)
          FadeTransition(
            opacity: _bgFade,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary900.withValues(alpha: 0.55),
                    AppColors.primary900.withValues(alpha: 0.15),
                    AppColors.primary900.withValues(alpha: 0.45),
                  ],
                ),
              ),
            ),
          ),

          // ── Content ─────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wp(8)),
              child: Column(
                children: [
                  // Push logo block to optical center (slightly above true center)
                  const Spacer(flex: 5),

                  // LOGO BLOCK
                  FadeTransition(
                    opacity: _logoFade,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: Image.asset(
                        'assets/images/splash logo.png',
                        // Figma-matched size: prominent but not oversized
                        width: context.responsive(
                          mobile: context.wp(52),
                          tablet: context.wp(36),
                          desktop: context.wp(22),
                        ),
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => _FallbackLogo(context),
                      ),
                    ),
                  ),

                  SizedBox(height: context.hp(2.8)),

                  // TAGLINE
                  FadeTransition(
                    opacity: _taglineFade,
                    child: SlideTransition(
                      position: _taglineSlide,
                      child: Text(
                        'Where Ideas Reach New Heights.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyLarge(
                          context,
                          color: AppColors.textInverse.withValues(alpha: 0.92),
                          fontWeight: FontWeight.w400,
                        ).copyWith(
                          letterSpacing: 0.2,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(flex: 4),

                  // FOOTER
                  FadeTransition(
                    opacity: _footerFade,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: context.hp(3.5)),
                      child: Text(
                        'Learning  •  Building  •  Growing',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySmall(
                          context,
                          color: AppColors.primary300,
                          fontWeight: FontWeight.w400,
                        ).copyWith(
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Fallback if splash logo asset missing — matches Figma icon + wordmark
  Widget _FallbackLogo(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Mountain peak icon
        Icon(
          Icons.landscape_rounded,
          size: context.responsive(
            mobile: context.wp(18),
            tablet: context.wp(12),
            desktop: context.wp(8),
          ),
          color: AppColors.textInverse,
        ),
        SizedBox(height: context.hp(1.2)),
        Text(
          'EVERMONT',
          style: AppTextStyles.display(
            context,
            color: AppColors.textInverse,
            fontWeight: FontWeight.w700,
          ).copyWith(
            letterSpacing: 3.5,
            fontSize: context.responsive(
              mobile: context.sp(28),
              tablet: context.sp(32),
              desktop: context.sp(36),
            ),
          ),
        ),
      ],
    );
  }
}
