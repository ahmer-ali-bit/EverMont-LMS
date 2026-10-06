import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';

enum ButtonVariant { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final bool isLoading;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // final bool isPrimary = variant == ButtonVariant.primary;
    final bool isOutline = variant == ButtonVariant.outline;

    Color getBgColor() {
      if (variant == ButtonVariant.primary) return AppColors.primary800;
      if (variant == ButtonVariant.secondary) return AppColors.primary100;
      return Colors.transparent;
    }

    Color getTextColor() {
      if (variant == ButtonVariant.primary) return AppColors.textInverse;
      if (variant == ButtonVariant.secondary) return AppColors.primary800;
      return AppColors.primary800;
    }

    return SizedBox(
      width: double.infinity,
      height: context.hp(6.5).clamp(48.0, 60.0), // Responsive height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: getBgColor(),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isOutline
                ? const BorderSide(color: AppColors.border)
                : BorderSide.none,
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const CircularProgressIndicator(color: AppColors.surface)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[icon!, SizedBox(width: context.wp(2))],
                  Text(
                    text,
                    style: AppTextStyles.bodyLarge(context,
                        color: getTextColor(), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
      ),
    );
  }
}
