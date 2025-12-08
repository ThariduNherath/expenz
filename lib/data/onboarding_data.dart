import 'package:expenz/models/onboarding_modal.dart';

class OnboardingData {
  static final List<Onboarding> onboardingDataList = [
    Onboarding(
      title: "Gain total control 0f your money",
      description:
          "Effortlessly record every expense and see where your money really goes. Stay in control of your financial life",

      imagePath: "assets/images/onboard_1.png",
    ),

    Onboarding(
      title: "Know Where your money goes",
      description:
          "Visualize your spending habits with detailed charts and reports. Identify areas to save and make smarter financial choices.",

      imagePath: "assets/images/onboard_2.png",
    ),

    Onboarding(
      title: "Planning Ahead",
      description:
          "Plan for the future with confidence. Create savings goals, monitor your investments, and make informed financial decisions.",

      imagePath: "assets/images/onboard_3.png",
    ),
  ];
}
