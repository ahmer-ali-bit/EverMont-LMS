/// forgot_password_screen.dart - Request password reset code
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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSendCode() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<AuthProvider>();
    final success = await provider.forgotPassword(_emailCtrl.text.trim());

    if (success && mounted) {
      context.push('/reset-password');
      // Real flow: often go to OTP first, then reset
      // context.push('/otp-verification');
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => context.pop(),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
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
                    padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: context.hp(4)),
                          Icon(
                            Iconsax.lock_circle,
                            size: context.sp(64),
                            color: AppColors.primary800,
                          ),
                          SizedBox(height: context.hp(4)),
                          Text(
                            'Forgot Password?',
                            style: AppTextStyles.h1(context),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: context.hp(1)),
                          Text(
                            "Enter your registered email or phone number and we'll help you reset your password.",
                            style: AppTextStyles.bodyMedium(context),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: context.hp(5)),
                          CustomTextField(
                            hintText: 'Email / Phone',
                            prefixIcon: Iconsax.sms,
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.email,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // PINNED BUTTON
                Padding(
                  padding: EdgeInsets.all(context.wp(6)),
                  child: Consumer<AuthProvider>(
                    builder: (context, provider, _) => CustomButton(
                      text: 'Send Code',
                      isLoading: provider.isLoading,
                      onPressed: _handleSendCode,
                    ),
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
