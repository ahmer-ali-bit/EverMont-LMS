import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../shared/widgets/custom_button.dart';
import '../providers/auth_provider.dart';
import '../widgets/role_card.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: context.isDesktop ? context.wp(40) : double.infinity),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
              child: Consumer<AuthProvider>(
                builder: (context, provider, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset('assets/images/evermont logo.png',
                          height: context.hp(8)),
                      SizedBox(height: context.hp(4)),
                      Text('Welcome to Evermont LMS',
                          style: AppTextStyles.h1(context),
                          textAlign: TextAlign.center),
                      SizedBox(height: context.hp(1)),
                      Text('Select your account type to continue.',
                          style: AppTextStyles.bodyMedium(context),
                          textAlign: TextAlign.center),
                      SizedBox(height: context.hp(4)),
                      RoleCard(
                        icon: Iconsax.teacher,
                        title: 'Student / Intern',
                        subtitle:
                            'Learn courses, complete assignments and work on projects.',
                        isSelected: provider.selectedRole == 'student',
                        onTap: () => provider.setRole('student'),
                      ),
                      RoleCard(
                        icon: Iconsax.profile_2user,
                        title: 'Instructor / Mentor',
                        subtitle:
                            'Teach courses, manage students and review projects.',
                        isSelected: provider.selectedRole == 'instructor',
                        onTap: () => provider.setRole('instructor'),
                      ),
                      RoleCard(
                        icon: Iconsax.setting_2,
                        title: 'Admin',
                        subtitle: 'Manage the complete Evermont LMS.',
                        isSelected: provider.selectedRole == 'admin',
                        onTap: () => provider.setRole('admin'),
                      ),
                      const Spacer(),
                      CustomButton(
                          text: 'Continue',
                          onPressed: () => context.go('/login')),
                      SizedBox(height: context.hp(4)),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
