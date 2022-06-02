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
    title: 'Bienvenido a\n Maxqui Shop',
    image: 'assets/svg/page3.svg',
  ),
  OnBoarding(
    title: 'Esta disponible las 24 horas del día',
    image: 'assets/svg/page2.svg',
  ),
  OnBoarding(
    title: 'Puedes encontrar a todos los emprendedores de la Parroquia',
    image: 'assets/svg/page1.svg',
  ),
  OnBoarding(
    title: 'Ayuda al comercio local',
    image: 'assets/svg/page4.svg',
  ),
];
