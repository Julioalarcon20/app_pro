import 'package:flutter/material.dart';
import '../../app_styles.dart';
import '../../size_configs.dart';
import '../../validators.dart';
import '../pages.dart';
import '../../widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

// its best practice to do relative imports

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();

  void onSubmit() {
    _loginKey.currentState!.validate();
  }

  List<FocusNode> _loginFocusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    super.initState();
    _loginFocusNodes.forEach((element) {
      element.addListener(() {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = SizeConfig.blockSizeV!;
    return Stack(
      children: [
        Positioned(
          bottom: height * 2,
          child: Image.asset('assets/image/auth/login_bg.png'),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          // Text(
                          //   '\nM',
                          //   style: TextStyle(
                          //       color: Color(0xffFC5939),
                          //       fontSize: 30,
                          //       fontWeight: FontWeight.bold),
                          //   textAlign: TextAlign.center,
                          // ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: const [
                                SizedBox(
                                  height: 10,
                                ),
                                // LargeIconButton(
                                //   buttonName: 'Continuar con Google',
                                //   color: Colors.red,
                                //   iconImage:
                                //       'assets/image/auth/google_icon.png',
                                // ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff0E112E),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    'Iniciar sesión con correo electrónico',
                                    style: kBodyText3,
                                  ),
                                  Divider(
                                    height: 30,
                                    color: kPrimaryColor.withOpacity(0.5),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Form(
                                      key: _loginKey,
                                      child: Column(
                                        children: [
                                          MyTextFormField(
                                            hint: 'Email',
                                            icon: Icons.email_outlined,
                                            fillColor: const Color(0xff201753),
                                            inputType:
                                                TextInputType.emailAddress,
                                            inputAction: TextInputAction.next,
                                            focusNode: _loginFocusNodes[0],
                                            validator: emailValidator,
                                          ),
                                          MyPasswordField(
                                            fillColor: const Color(0xff201753),
                                            focusNode: _loginFocusNodes[1],
                                            validator: passwordValidator,
                                          ),
                                          MyTextButton(
                                            buttonName: 'Iniciar sesión',
                                            onPressed: onSubmit,
                                            bgColor: kPrimaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPasswordPage()));
                                    },
                                    child: Text(
                                      '¿Has olvidado tu contraseña?',
                                      style: kBodyText3.copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "¿No tienes una cuenta? ",
                                        style:
                                            TextStyle(color: Color(0xffFC5939)),
                                      ),
                                      SmallTextButton(
                                        buttonText: 'Regístrate',
                                        page: SignUpPage(),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
