import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
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
  bool _isLoading = false;
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
                                            fillColor: ktercero,
                                            inputType:
                                                TextInputType.emailAddress,
                                            inputAction: TextInputAction.next,
                                            focusNode: _loginFocusNodes[0],
                                            validator: emailValidator,
                                          ),
                                          MyPasswordField(
                                            hint: 'Contraseña',
                                            controller: _password,
                                            fillColor: ktercero,
                                            focusNode: _loginFocusNodes[1],
                                            validator: passwordValidatoro,
                                          ),
                                          MyTextButton(
                                            buttonName: _isLoading
                                                ? 'Cargando...'
                                                : 'Inicio de Sesión',
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
                                            color: kPrimaryColor, fontSize: 20),
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
    setState(() {
      _isLoading = true;
    });
var connectivityResult = await (Connectivity().checkConnectivity());
    if (_loginKey.currentState!.validate()) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var data = {'email': _email.text, 'password': _password.text};
        var res = await CallApi().postData(data, 'login');
        var body = json.decode(res.body);
        if (body['success'] == false) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "El usuario aun no se encuentra registado o revisa las credenciales ingresadas",
                style: TextStyle(color: kSecondaryColor)),
            backgroundColor: kPrimaryColor,
          ));
        } else {
          if (body['success']) {
            SharedPreferences localStorage =
                await SharedPreferences.getInstance();
            localStorage.setString('access_token', body['access_token']);
            localStorage.setString('user', json.encode(body['user']));

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (BuildContext context) {
              return new Home();
            }), (Route<dynamic> route) => false);
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("El dispositivo no tiene una conexion a internet",
              style: TextStyle(color: kSecondaryColor)),
          backgroundColor: kPrimaryColor,
        ));
      }
    } else {
      _loginKey.currentState!.validate();
    }
    setState(() {
      _isLoading = false;
    });
  }
}
