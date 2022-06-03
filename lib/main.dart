import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxqui_shop/app_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './views/pages.dart';

bool? seenOnboard;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // to show status bar
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  // to load onboard for the first time only
  SharedPreferences pref = await SharedPreferences.getInstance();
  seenOnboard = pref.getBool('seenOnboard') ?? false; //if null set to false

  runApp(const MyApp());
}

const MaterialColor myColour =
    const MaterialColor(0xff0E112E, const <int, Color>{
  50: const Color(0xff0E112E),
  100: const Color(0xff0E112E),
  200: const Color(0xff0E112E),
  300: const Color(0xff0E112E),
  400: const Color(0xff0E112E),
  500: const Color(0xff0E112E),
  600: const Color(0xff0E112E),
  700: const Color(0xff0E112E),
  800: const Color(0xff0E112E),
  900: const Color(0xff0E112E),
});

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maxqui Shop',
        theme: ThemeData(
          textTheme: GoogleFonts.mulishTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: myColour,
          scaffoldBackgroundColor: kScaffoldBackground,
        ),
        home: seenOnboard == true ? SignUpPage() : const OnBoardingPage());
  }
}
