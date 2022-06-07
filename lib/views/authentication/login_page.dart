import 'dart:convert';
import 'package:flutter/material.dart';
import '../../app_styles.dart';
import '../../size_configs.dart';
import '../../validators.dart';
import '../pages.dart';
import '../../widgets/widgets.dart';
import '../../api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

// its best practice to do relative imports

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  final List<FocusNode> _loginFocusNodes = [
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
          child: Image.asset('assets/image/login_bg.png'),
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
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: kScaffoldBackground,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    'Iniciar sesión',
                                    style: kBodyText2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Form(
                                      key: _loginKey,
                                      child: Column(
                                        children: [
                                          MyTextFormField(
                                            controller: _email,
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
                                            hint: 'Contraseña',
                                            controller: _password,
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
                                        style: TextStyle(
                                            color: Color(0xffFC5939),
                                            fontSize: 20),
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

   onSubmit() async {
    if (_loginKey.currentState!.validate()) {
      var data = {'email': _email.text, 'password': _password.text};
      var res = await CallApi().postData(data, 'login');
      var body = json.decode(res.body);
      if (body['success']) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('access_token', body['access_token']);
        localStorage.setString('user', json.encode(body['user']));
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => Home()));
      }
    } else {
      _loginKey.currentState!.validate();
    }
  }
}
