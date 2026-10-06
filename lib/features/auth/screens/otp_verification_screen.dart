import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../shared/widgets/custom_button.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Iconsax.arrow_left),
              onPressed: () => context.pop())),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: context.isDesktop ? context.wp(40) : double.infinity),
            child: Padding(
              padding: EdgeInsets.all(context.wp(6)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Iconsax.sms_tracking,
                      size: context.sp(64), color: AppColors.primary800),
                  SizedBox(height: context.hp(4)),
                  Text('Verify Your Account',
                      style: AppTextStyles.h1(context),
                      textAlign: TextAlign.center),
                  SizedBox(height: context.hp(1)),
                  Text(
                      'We\'ve sent a 6-digit verification code\nto your email/phone.',
                      style: AppTextStyles.bodyMedium(context),
                      textAlign: TextAlign.center),
                  SizedBox(height: context.hp(5)),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: context.hp(7),
                      fieldWidth: context.wp(12),
                      activeFillColor: AppColors.surface,
                      inactiveFillColor: AppColors.surface,
                      selectedFillColor: AppColors.primary50,
                      activeColor: AppColors.primary800,
                      inactiveColor: AppColors.border,
                      selectedColor: AppColors.primary500,
                    ),
                    onChanged: (value) {},
                  ),
                  SizedBox(height: context.hp(3)),
                  Text('Resend Code (00:45)',
                      style: AppTextStyles.bodyMedium(context,
                          color: AppColors.primary500,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center),
                  const Spacer(),
                  CustomButton(
                      text: 'Verify',
                      onPressed: () => context.push('/account-verified')),
                  SizedBox(height: context.hp(4)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
