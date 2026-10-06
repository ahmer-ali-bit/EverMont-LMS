/// password_strength.dart - Visual password strength indicator
/// Feature: Auth

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';

class PasswordStrength extends StatelessWidget {
  final String password;

  const PasswordStrength({super.key, required this.password});

  int get _score {
    if (password.isEmpty) return 0;
    int s = 0;
    if (password.length >= 6) s++;
    if (password.length >= 8) s++;
    if (RegExp(r'[A-Z]').hasMatch(password)) s++;
    if (RegExp(r'[0-9]').hasMatch(password)) s++;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) s++;
    return s.clamp(0, 3);
  }

  String get _label {
    switch (_score) {
      case 0:
        return '';
      case 1:
        return 'Weak';
      case 2:
        return 'Medium';
      default:
        return 'Strong';
    }
  }

  Color get _color {
    switch (_score) {
      case 1:
        return AppColors.error;
      case 2:
        return AppColors.gold;
      case 3:
        return AppColors.success;
      default:
        return AppColors.border;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) return const SizedBox.shrink();

    return Row(
      children: [
        Expanded(
          child: Row(
            children: List.generate(3, (i) {
              return Expanded(
                child: Container(
                  height: context.hp(0.5).clamp(3.0, 5.0),
                  margin: EdgeInsets.only(right: i < 2 ? context.wp(1) : 0),
                  decoration: BoxDecoration(
                    color: i < _score ? _color : AppColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(width: context.wp(3)),
        Text(
          _label,
          style: AppTextStyles.bodySmall(context,
              color: _color, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
