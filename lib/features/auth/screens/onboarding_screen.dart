import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../shared/widgets/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/images/onboarding 1.png',
      'title': 'Learn New Skills',
      'desc':
          'Build practical skills through structured courses and hands-on learning.',
    },
    {
      'image': 'assets/images/onboarding 2.png',
      'title': 'Work on Real Projects',
      'desc':
          'Turn your knowledge into experience by working on practical projects and tasks.',
    },
    {
      'image': 'assets/images/onboarding 3.png',
      'title': 'Track Your Growth',
      'desc':
          'Monitor your courses, attendance, projects, internship progress and certificates in one place.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: context.isDesktop ? context.wp(40) : double.infinity),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) =>
                        setState(() => _currentPage = index),
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: context.wp(6)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(_pages[index]['image']!,
                                height: context.hp(35)),
                            SizedBox(height: context.hp(5)),
                            Text(
                              _pages[index]['title']!,
                              style: AppTextStyles.h1(context),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: context.hp(2)),
                            Text(
                              _pages[index]['desc']!,
                              style: AppTextStyles.bodyMedium(context),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? AppColors.primary800
                            : AppColors.primary200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: context.hp(4)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
                  child: CustomButton(
                    text: _currentPage == 2 ? 'Get Started →' : 'Next →',
                    onPressed: () {
                      if (_currentPage == 2) {
                        context.go('/role-selection');
                      } else {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                      }
                    },
                  ),
                ),
                SizedBox(height: context.hp(2)),
                TextButton(
                  onPressed: () => context.go('/role-selection'),
                  child: Text('Skip',
                      style: AppTextStyles.bodyMedium(context,
                          color: AppColors.primary800,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: context.hp(4)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
