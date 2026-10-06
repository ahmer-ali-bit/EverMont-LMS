/// login_screen.dart - User login with email/password
/// Feature: Auth

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/utils/validators.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_textfield.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<AuthProvider>();
    final success =
        await provider.login(_emailCtrl.text.trim(), _passwordCtrl.text);

    if (success && mounted) {
      // TODO: Navigate to dashboard when Module 02 is ready
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful!')),
      );
    } else if (mounted && provider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.errorMessage!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.isDesktop ? context.wp(40) : double.infinity,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            'assets/images/login image.png',
                            height: context.hp(25),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => SizedBox(
                              height: context.hp(25),
                              child:
                                  const ColoredBox(color: AppColors.primary50),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.wp(6),
                              vertical: context.hp(2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('Welcome Back 👋',
                                    style: AppTextStyles.h1(context)),
                                SizedBox(height: context.hp(1)),
                                Text(
                                  'Sign in to continue your learning journey.',
                                  style: AppTextStyles.bodyMedium(context),
                                ),
                                SizedBox(height: context.hp(4)),
                                CustomTextField(
                                  hintText: 'Email / Phone',
                                  prefixIcon: Iconsax.sms,
                                  controller: _emailCtrl,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: Validators.email,
                                ),
                                SizedBox(height: context.hp(2)),
                                CustomTextField(
                                  hintText: 'Password',
                                  prefixIcon: Iconsax.lock,
                                  isPassword: true,
                                  controller: _passwordCtrl,
                                  validator: Validators.password,
                                ),
                                SizedBox(height: context.hp(2)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: context.sp(24),
                                          width: context.sp(24),
                                          child: Checkbox(
                                            value: _rememberMe,
                                            onChanged: (v) => setState(
                                                () => _rememberMe = v ?? false),
                                            activeColor: AppColors.primary800,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                          ),
                                        ),
                                        SizedBox(width: context.wp(2)),
                                        Text(
                                          'Remember me',
                                          style:
                                              AppTextStyles.bodyMedium(context),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          context.push('/forgot-password'),
                                      child: Text(
                                        'Forgot Password?',
                                        style: AppTextStyles.bodyMedium(
                                          context,
                                          color: AppColors.primary800,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // PINNED BOTTOM
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    context.wp(6),
                    context.hp(1),
                    context.wp(6),
                    context.hp(3),
                  ),
                  child: Column(
                    children: [
                      Consumer<AuthProvider>(
                        builder: (context, provider, _) => CustomButton(
                          text: 'Login',
                          isLoading: provider.isLoading,
                          onPressed: _handleLogin,
                        ),
                      ),
                      SizedBox(height: context.hp(2)),
                      Row(
                        children: [
                          const Expanded(
                              child: Divider(color: AppColors.border)),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: context.wp(4)),
                            child: Text('OR',
                                style: AppTextStyles.bodySmall(context)),
                          ),
                          const Expanded(
                              child: Divider(color: AppColors.border)),
                        ],
                      ),
                      SizedBox(height: context.hp(2)),
                      CustomButton(
                        text: 'Continue with Google',
                        variant: ButtonVariant.outline,
                        // Iconsax has no google_play — use Material Icons.g_mobiledata
                        // or a simple colored "G" style icon
                        icon: Icon(
                          Icons.g_mobiledata_rounded,
                          color: AppColors.error,
                          size: context.sp(28),
                        ),
                        onPressed: () {
                          // TODO(API): Google Sign-In
                        },
                      ),
                      SizedBox(height: context.hp(3)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: AppTextStyles.bodyMedium(context),
                          ),
                          GestureDetector(
                            onTap: () => context.push('/register'),
                            child: Text(
                              'Create Account',
                              style: AppTextStyles.bodyMedium(
                                context,
                                color: AppColors.primary800,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
