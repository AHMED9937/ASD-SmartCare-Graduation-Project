import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/design_system/tokens/colors.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/auth/onboarding/widgets/onboarding_page_content.dart';
import 'package:asdsmartcare/shared/auth/onboarding/widgets/onboarding_nav_bar.dart';
import 'package:asdsmartcare/shared/auth/login/views/auth_selection_screen.dart';
import 'package:flutter/material.dart';

class OnboardingNavigationScreens extends StatefulWidget {
  const OnboardingNavigationScreens({super.key});

  @override
  State<OnboardingNavigationScreens> createState() =>
      _OnboardingNavigationScreensState();
}

class _OnboardingNavigationScreensState
    extends State<OnboardingNavigationScreens> {
  final PageController pageController = PageController();
  bool isLastPage = false;

  final List<Widget> pages = const [
    OnboardingPageContent(
      title: 'Comprehensive Support for Your Child Starts Here',
      description:
          'Innovative tools to improve the lives of children with autism.',
      imageLink: 'lib/appassets/images/onboarding1.png',
    ),
    OnboardingPageContent(
      title: 'Easy Assessment and Diagnosis',
      description:
          'An intelligent chatbot for evaluation, with recommendations for the best doctors.',
      imageLink: 'lib/appassets/images/onboarding2.png',
    ),
    OnboardingPageContent(
      title: 'Your First Step Toward Change',
      description:
          'Create your account today and start supporting your child the way they deserve.',
      imageLink: 'lib/appassets/images/onboarding3.png',
    ),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    CacheHelper.saveData(key: 'loginSingUp', value: true)
        .then((value) {
          if (value != null && mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AuthSelectionScreen(),
              ),
            );
          }
        })
        .catchError((error) {
          debugPrint(error.toString());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // 1. Page View
            PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == pages.length - 1;
                });
              },
              children: pages,
            ),

            // 2. Skip Button
            if (!isLastPage)
              Positioned(
                top: 20,
                right: 20,
                child: TextButton(
                  onPressed: _navigateToLogin,
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: AppColors.primaryDark.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            // 3. Navigation Bar
            Positioned(
              bottom: 30,
              left: 24,
              right: 24,
              child: OnboardingNavBar(
                pageController: pageController,
                pageCount: pages.length,
                isLastPage: isLastPage,
                onNext: isLastPage
                    ? _navigateToLogin
                    : () {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
