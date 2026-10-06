// lib/features/auth/screens/success_screen.dart (Reusable for 11 & 12)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../shared/widgets/custom_button.dart';

class SuccessScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final String routeName;

  const SuccessScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: context.isDesktop ? context.wp(40) : double.infinity),
          child: Padding(
            padding: EdgeInsets.all(context.wp(6)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(context.wp(8)),
                  decoration: const BoxDecoration(
                      color: AppColors.success, shape: BoxShape.circle),
                  child: Icon(Icons.check,
                      size: context.sp(48), color: AppColors.surface),
                ),
                SizedBox(height: context.hp(4)),
                Text(title,
                    style: AppTextStyles.h1(context),
                    textAlign: TextAlign.center),
                SizedBox(height: context.hp(2)),
                Text(subtitle,
                    style: AppTextStyles.bodyMedium(context),
                    textAlign: TextAlign.center),
                SizedBox(height: context.hp(6)),
                CustomButton(
                    text: buttonText, onPressed: () => context.go(routeName)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
