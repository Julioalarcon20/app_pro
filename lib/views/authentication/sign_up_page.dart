import 'dart:convert';
import 'package:flutter/material.dart';
import '../../app_styles.dart';
import '../../size_configs.dart';
import '../../validators.dart';
import '../pages.dart';
import '../../widgets/widgets.dart';
import '../../api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ressController = TextEditingController();

  List<FocusNode> _signUpFocusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _signUpFocusNodes.forEach((element) {
      element.addListener(() {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = SizeConfig.blockSizeV!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Image.asset('assets/image/auth/signup_illustration.png'),
                Container(
                  child: (SvgPicture.asset('assets/svg/registro.svg',
                      width: 200, height: 200)),
                ),
                SizedBox(
                  height: height * 2,
                ),
                Text(
                  'Crear una cuenta',
                  style: kTitle2,
                ),
                SizedBox(
                  height: height * 2,
                ),
                Form(
                  key: _signUpKey,
                  child: Column(
                    children: [
                      MyTextFormField(
                        controller: firstNameController,
                        fillColor: ktercero,
                        hint: 'Nombre',
                        icon: Icons.person,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.name,
                        focusNode: _signUpFocusNodes[0],
                        validator: nameValidator,
                      ),
                      MyTextFormField(
                          controller: mailController,
                          hint: 'Email',
                          icon: Icons.email_outlined,
                          fillColor: ktercero,
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          focusNode: _signUpFocusNodes[1],
                          validator: emailValidator),
                      MyPasswordField(
                        hint: 'Contraseña',
                        controller: passwordController,
                        fillColor: ktercero,
                        focusNode: _signUpFocusNodes[2],
                        validator: passwordValidator,
                      ),
                      MyPasswordField(
                        hint: 'Repetir Contraseña',
                        controller: ressController,
                        fillColor: ktercero,
                        focusNode: _signUpFocusNodes[3],
                        validator: password_confiValidator,
                      ),
                      const MyCheckBox(
                        text: 'Aceptar terminos y condiciones de servicio',
                      ),
                      MyTextButton(
                        buttonName: _isLoading ? 'Cargando...' :  'Crear cuenta',
                        onPressed: () => {
                           onSubmit(),
                        },
                        bgColor: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          height: 3,
                          color: kSecondaryColor.withOpacity(0.4),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          height: 3,
                          color: kSecondaryColor.withOpacity(0.4),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      '¿Ya tienes una cuenta? ',
                      style: TextStyle(color: Color(0xffFC5939), fontSize: 20),
                    ),
                    SmallTextButton(
                      buttonText: 'Iniciar sesión',
                      page: LoginPage(),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onSubmit() async {
    setState(() {
      _isLoading = true;
    });
    // _signUpKey.currentState!.validate();
    if (_signUpKey.currentState!.validate()) {
      if (passwordController.text == ressController.text) {
        var data = {
          'Nombre': firstNameController.text,
          'email': mailController.text,
          'password': passwordController.text,
          'password_confirmation': ressController.text,
        };
        var res = await CallApi().postData(data, 'registro');
        var body = json.decode(res.body);
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Las contraseñas ingresadas no coinciden",
              style: TextStyle(color: kSecondaryColor)),
          backgroundColor: kPrimaryColor,
        ));
      }
    } else {
      _signUpKey.currentState!.validate();
    }
    setState(() {
      _isLoading = false;
    });
  }
}
