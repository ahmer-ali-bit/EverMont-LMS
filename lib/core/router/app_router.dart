import 'package:evermont_lms/features/auth/screens/forgot_password_screen.dart';
import 'package:evermont_lms/features/auth/screens/reset_password_screen.dart';
import 'package:evermont_lms/features/auth/screens/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'app_routes.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/onboarding_screen.dart';
import '../../features/auth/screens/role_selection_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/otp_verification_screen.dart';
// Note: Assuming success screens are imported as before

// Wrapper for Auth Screens to inject provider LOCALLY
Widget _authWrapper(Widget child) {
  return ChangeNotifierProvider(
    create: (_) => AuthProvider(),
    child: child,
  );
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen()),
    GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen()),

    // Screens below need AuthProvider, so we wrap them individually
    GoRoute(
      path: AppRoutes.roleSelection,
      builder: (context, state) => _authWrapper(const RoleSelectionScreen()),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => _authWrapper(const LoginScreen()),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => _authWrapper(const RegisterScreen()),
    ),
    GoRoute(
      path: AppRoutes.otpVerification,
      builder: (context, state) => _authWrapper(const OtpVerificationScreen()),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => _authWrapper(const ForgotPasswordScreen()),
    ),
    GoRoute(
      path: AppRoutes.resetPassword,
      builder: (context, state) => _authWrapper(const ResetPasswordScreen()),
    ),
    GoRoute(
      path: AppRoutes.passwordSuccess,
      builder: (context, state) => const SuccessScreen(
        title: 'Password Updated',
        subtitle: 'Your password has been successfully changed.',
        buttonText: 'Back to Login',
        routeName: AppRoutes.login,
      ),
    ),
    GoRoute(
      path: AppRoutes.accountVerified,
      builder: (context, state) => const SuccessScreen(
        title: "You're All Set!",
        subtitle: 'Your Evermont LMS account has been successfully verified.',
        buttonText: 'Continue to Dashboard',
        routeName: AppRoutes.login,
      ),
    ),
  ],
);
