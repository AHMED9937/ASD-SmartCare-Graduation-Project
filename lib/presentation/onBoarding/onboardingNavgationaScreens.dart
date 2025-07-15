import 'package:asdsmartcare/appShared/cacheHelper/cahcheHelper.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/colorUtils.dart';
import 'package:asdsmartcare/presentation/login/screen/SelectusertypeScreen.dart';
import 'package:asdsmartcare/presentation/onBoarding/onBoardingWidget.dart';
import 'package:asdsmartcare/presentation/login/screen/select_Login_or_SignUpScreen.dart';
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
            "lib/appassets/images/onboarding1.png"),
    onBoardingScreen(
        title: "Easy Assessment and Diagnosis",
        discrption:
            "An intelligent chatbot for evaluation, with recommendations for the best doctors and quick appointment booking.",
        image_Link:
            "lib/appassets/images/onboarding2.png"),
    onBoardingScreen(
        title: "Your First Step Toward Change",
        discrption:
            "Create your account today and start supporting your child the way they deserve.",
        image_Link:
            "lib/appassets/images/onboarding3.png"),
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
    extendBodyBehindAppBar: true,              // ✱ allow the body to draw under the AppBar
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.transparent,     // ✱ make the AppBar see-through
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: !isLastPage                       // ✱ show Skip until last page
          ? [
              TextButton(
                onPressed: () => pageController.jumpToPage(onboardingScreens.length - 1),
                child: const Text("Skip", style: TextStyle(color: Colors.black)),
              ),
            ]
          : null,
    ),
    body: PageView(
      controller: pageController,
      onPageChanged: (i) => setState(() {
        isFirstPage = i == 0;
        isLastPage  = i == onboardingScreens.length - 1;
      }),
      children: onboardingScreens,
    ),
    bottomSheet: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmoothPageIndicator(
            controller: pageController,
            count: onboardingScreens.length,
            effect: const WormEffect(
              dotWidth: 16.84, dotHeight: 4.65, spacing: 1.74,
              activeDotColor: const Color(0xFF133E87),
              dotColor: Color(0xFFB2BFD9),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF133E87),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            ),
            onPressed: isLastPage ? _navigateToLogin : () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeIn,
              );
            },
            child: Text(isLastPage ? "Get Started" : "Next",style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
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
