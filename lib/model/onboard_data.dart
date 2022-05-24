class OnBoarding {
  final String title;
  final String image;

  OnBoarding({
    required this.title,
    required this.image,
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
    title: 'Bienvenido a \n Maxqui Shop',
    image: 'assets/image/onboarding_image_1.png',
  ),
  OnBoarding(
    title: 'Create new habits easily',
    image: 'assets/image/onboarding_image_2.png',
  ),
  OnBoarding(
    title: 'Keep track of your progress',
    image: 'assets/image/onboarding_image_3.png',
  ),
  OnBoarding(
    title: 'Join a supportive community',
    image: 'assets/image/onboarding_image_4.png',
  ),
];
