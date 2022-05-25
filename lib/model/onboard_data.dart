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
    title: 'Productos 100% locales',
    image: 'assets/image/onboarding_image_2.png',
  ),
  OnBoarding(
    title: 'Una menera mas fácil de contactar al emprendedor',
    image: 'assets/image/onboarding_image_3.png',
  ),
  OnBoarding(
    title: 'Ayuda al comercio local',
    image: 'assets/image/onboarding_image_4.png',
  ),
];
