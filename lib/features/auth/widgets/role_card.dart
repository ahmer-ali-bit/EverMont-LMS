import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';

class RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: context.hp(2)),
        padding: EdgeInsets.all(context.wp(4)),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary50 : AppColors.surface,
          border: Border.all(
              color: isSelected ? AppColors.primary800 : AppColors.border,
              width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  color: AppColors.primary100, shape: BoxShape.circle),
              child: Icon(icon, color: AppColors.primary800),
            ),
            SizedBox(width: context.wp(4)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: AppTextStyles.bodyLarge(context,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: context.hp(0.5)),
                  Text(subtitle, style: AppTextStyles.bodySmall(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
