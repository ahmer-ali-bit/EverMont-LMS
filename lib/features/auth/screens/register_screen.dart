/// register_screen.dart - Create new account form
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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to Terms & Conditions')),
      );
      return;
    }

    final provider = context.read<AuthProvider>();
    final success = await provider.register(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      password: _passwordCtrl.text,
    );

    if (success && mounted) {
      context.push('/otp-verification');
    } else if (mounted && provider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.errorMessage!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gap sizes tweaked so it fits perfectly on standard phones
    final gap = SizedBox(height: context.hp(1.8));

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
            // CustomScrollView + SliverFillRemaining = The Ultimate Fixed Layout
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  hasScrollBody:
                      false, // Prevents scrolling when keyboard is closed
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header Section
                          Text('Create Your Account',
                              style: AppTextStyles.h1(context)),
                          SizedBox(height: context.hp(0.8)),
                          Text(
                            'Join Evermont and start your learning journey.',
                            style: AppTextStyles.bodyMedium(context),
                          ),
                          SizedBox(height: context.hp(3.5)),

                          // Form Fields
                          CustomTextField(
                            hintText: 'Full Name',
                            prefixIcon: Iconsax.user,
                            controller: _nameCtrl,
                            validator: (v) => Validators.required(v, 'Name'),
                          ),
                          gap,

                          CustomTextField(
                            hintText: 'Email',
                            prefixIcon: Iconsax.sms,
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.email,
                          ),
                          gap,

                          CustomTextField(
                            hintText: 'Phone Number',
                            prefixIcon: Iconsax.call,
                            controller: _phoneCtrl,
                            keyboardType: TextInputType.phone,
                            validator: (v) =>
                                Validators.required(v, 'Phone Number'),
                          ),
                          gap,

                          CustomTextField(
                            hintText: 'Password',
                            prefixIcon: Iconsax.lock,
                            isPassword: true,
                            controller: _passwordCtrl,
                            validator: Validators.password,
                          ),
                          gap,

                          CustomTextField(
                            hintText: 'Confirm Password',
                            prefixIcon: Iconsax.lock,
                            isPassword: true,
                            controller: _confirmCtrl,
                            validator: (v) => Validators.confirmPassword(
                                v, _passwordCtrl.text),
                          ),
                          gap,

                          Row(
                            children: [
                              SizedBox(
                                height: context.sp(24),
                                width: context.sp(24),
                                child: Checkbox(
                                  value: _agreedToTerms,
                                  onChanged: (v) => setState(
                                      () => _agreedToTerms = v ?? false),
                                  activeColor: AppColors.primary800,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                              SizedBox(width: context.wp(2)),
                              Expanded(
                                child: Text(
                                  'I agree to Terms & Conditions',
                                  style: AppTextStyles.bodySmall(context,
                                      color: AppColors.primary500),
                                ),
                              ),
                            ],
                          ),

                          // Spacer forces the button to the absolute bottom
                          const Spacer(),

                          // Pinned Bottom Button
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: context.hp(3), top: context.hp(2)),
                            child: Consumer<AuthProvider>(
                              builder: (context, provider, _) => CustomButton(
                                text: 'Create Account',
                                isLoading: provider.isLoading,
                                onPressed: _handleRegister,
                              ),
                            ),
                          ),
                        ],
                      ),
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
