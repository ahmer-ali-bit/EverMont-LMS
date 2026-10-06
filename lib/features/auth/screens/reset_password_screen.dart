/// reset_password_screen.dart - Create new password after OTP
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
import '../widgets/password_strength.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<AuthProvider>();
    final success = await provider.resetPassword(_passwordCtrl.text);

    if (success && mounted) {
      context.push('/password-success');
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
                            Iconsax.security_safe,
                            size: context.sp(64),
                            color: AppColors.primary800,
                          ),
                          SizedBox(height: context.hp(4)),
                          Text(
                            'Create New Password',
                            style: AppTextStyles.h1(context),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: context.hp(1)),
                          Text(
                            'Choose a strong password to keep your account safe.',
                            style: AppTextStyles.bodyMedium(context),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: context.hp(5)),
                          CustomTextField(
                            hintText: 'New Password',
                            prefixIcon: Iconsax.lock,
                            isPassword: true,
                            controller: _passwordCtrl,
                            validator: Validators.password,
                          ),
                          SizedBox(height: context.hp(2)),
                          CustomTextField(
                            hintText: 'Confirm Password',
                            prefixIcon: Iconsax.lock,
                            isPassword: true,
                            controller: _confirmCtrl,
                            validator: (v) => Validators.confirmPassword(
                                v, _passwordCtrl.text),
                          ),
                          SizedBox(height: context.hp(2)),
                          PasswordStrength(password: _passwordCtrl.text),
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
                      text: 'Reset Password',
                      isLoading: provider.isLoading,
                      onPressed: _handleReset,
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
