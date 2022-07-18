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
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _resetKey = GlobalKey<FormState>();
  TextEditingController token = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ressController = TextEditingController();

  List<FocusNode> _signUpFocusNodes = [
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: CircleAvatar(
            backgroundColor: kPrimaryColor.withOpacity(0.2),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: kSecondaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Image.asset('assets/image/auth/signup_illustration.png'),
                Container(
                  child: (SvgPicture.asset('assets/svg/codigo.svg',
                      width: 200, height: 200)),
                ),
                SizedBox(
                  height: height * 2,
                ),
                Text(
                  'Nueva Contraseña',
                  style: kTitle2,
                ),
                SizedBox(
                  height: height * 2,
                ),
                Form(
                  key: _resetKey,
                  child: Column(
                    children: [
                      MyTextFormField(
                        controller: token,
                        fillColor: ktercero,
                        hint: 'Ingresa el codigo',
                        icon: Icons.person,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.name,
                        focusNode: _signUpFocusNodes[0],
                        validator: nameValidator,
                      ),
                      MyPasswordField(
                        hint: 'Contraseña',
                        controller: passwordController,
                        fillColor: ktercero,
                        focusNode: _signUpFocusNodes[1],
                        validator: passwordValidator,
                      ),
                      MyPasswordField(
                        hint: 'Repetir Contraseña',
                        controller: ressController,
                        fillColor: ktercero,
                        focusNode: _signUpFocusNodes[2],
                        validator: password_confiValidator,
                      ),
                      MyTextButton(
                        buttonName: _isLoading ? 'Cargando...' : 'Crear cuenta',
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
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (_resetKey.currentState!.validate()) {
      var data = {
        'token': token.text,
        'password': passwordController.text,
        'password_confirmation': ressController.text,
      };
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        var res = await CallApi().postData(data, 'reset');
        var body = json.decode(res.body);
        if (body['success'] == false) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "El token ingresado no es valido debes realizar una nueva solicitud",
                style: TextStyle(color: kSecondaryColor)),
            backgroundColor: kPrimaryColor,
          ));
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return new LoginPage();
          }), (Route<dynamic> route) => false);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("El dispositivo no tiene una conexion a internet",
              style: TextStyle(color: kSecondaryColor)),
          backgroundColor: kPrimaryColor,
        ));
      }
    }
  }
}
