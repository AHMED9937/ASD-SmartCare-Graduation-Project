import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/login/screen/select_Login_or_SignUpScreen.dart';
import 'package:asdsmartcare/presentation/onBoarding/onBoardingWidget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingNavigationScreens extends StatefulWidget {
  const OnboardingNavigationScreens({Key? key}) : super(key: key);

  @override
  State<OnboardingNavigationScreens> createState() =>
      _OnboardingNavigationScreensState();
}

class _OnboardingNavigationScreensState
    extends State<OnboardingNavigationScreens> {
  void submit() {
    CacheHelper.SaveData(key: 'onBoardin', value: true).then((value) {
      if (value != null)
        pageController.jumpToPage(onboardingScreens.length - 1);
    });
  }

  final List<Widget> onboardingScreens = const [
    onBoardingScreen(
        title: "Comprehensive Support for Your Child Starts Here,",
        discrption:
            "Innovative tools to improve the lives of children with autism.",
        image_Link:
            "C:/Users/57992/Desktop/allpreojects/AsdSmartCare/lib/appassets/images/onboarding1.png"),
    onBoardingScreen(
        title: "Easy Assessment and Diagnosis",
        discrption:
            "An intelligent chatbot for evaluation, with recommendations for the best doctors and quick appointment booking.",
        image_Link:
            "C:/Users/57992/Desktop/allpreojects/AsdSmartCare/lib/appassets/images/onboarding2.png"),
    onBoardingScreen(
        title: "Your First Step Toward Change",
        discrption:
            "Create your account today and start supporting your child the way they deserve.",
        image_Link:
            "C:/Users/57992/Desktop/allpreojects/AsdSmartCare/lib/appassets/images/onboarding3.png"),
  ];

  final PageController pageController = PageController();
  bool isLastPage = false;
  bool isFirstPage = true;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == onboardingScreens.length - 1;
                isFirstPage = index == 0;
              });
            },
            children: onboardingScreens,
          ),
          if (!isFirstPage)
            Positioned(
              left: 10,
              top: 50,
              child: AppButtons.arrowbutton(() {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                );
              }),
            ),
          if (!isLastPage)
            Positioned(
              right: 10,
              top: 50,
              child: TextButton(
                onPressed: () =>
                    pageController.jumpToPage(onboardingScreens.length - 1),
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          Positioned(
            bottom: 35,
            left: 41,
            right: 41,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25B9D3),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: isLastPage
                  ? _navigateToLogin
                  : () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn,
                      );
                    },
              child: Text(
                isLastPage ? "Get Started" : "Next",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned(
            left: 167,
            bottom: 120,
            child: SmoothPageIndicator(
              controller: pageController,
              count: onboardingScreens.length,
              effect: const WormEffect(
                dotWidth: 16.84,
                dotHeight: 4.65,
                spacing: 1.74,
                activeDotColor: Color(0xFF25B9D3),
                dotColor: Color(0xFFB2BFD9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToLogin() {
    CacheHelper.SaveData(key: 'loginSingUp', value: true).then((value) {
      if (value != null)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SelectLoginOrSignupscreen()),
        );
    }).catchError((x){
      print(x.toString());
    });
  }
}
