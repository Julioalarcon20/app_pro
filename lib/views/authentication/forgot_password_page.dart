import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api.dart';
import '../../app_styles.dart';
import '../../size_configs.dart';
import '../../validators.dart';
import '../pages.dart';
import '../../widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _forgotPassKey = GlobalKey<FormState>();
  final email = TextEditingController();

  FocusNode focusNode1 = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode1.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    @override
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
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 3,
                  ),
                  Center(
                    child: Text(
                      "¿Olvidaste tu contraseña?",
                      style: kTitle2,
                    ),
                  ),
                  SizedBox(
                    height: height * 2,
                  ),
                  Container(
                    child: (SvgPicture.asset('assets/svg/recuperar_pass.svg',
                        width: 210, height: 210)),
                  ),
                  SizedBox(
                    height: height * 2,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: _forgotPassKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Ingresa tu correo electronico registrado dentro del sistema para poderte ayudar en el restablecimiento de la contraseña",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyTextFormField(
                              controller: email,
                              hint: 'Email',
                              icon: Icons.email_outlined,
                              fillColor: kScaffoldBackground,
                              inputType: TextInputType.emailAddress,
                              inputAction: TextInputAction.done,
                              focusNode: focusNode1,
                              validator: emailValidator,
                            ),
                            MyTextButton(
                              buttonName: 'Restablecer contraseña',
                              onPressed: _onSumbit,
                              bgColor: kPrimaryColor,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  _onSumbit()async{
     if (_forgotPassKey.currentState!.validate()) {
      var data={'email': email.text};
      var res = await CallApi().postData(data, 'forgot-password');
      var body = json.decode(res.body);
       if (body['success'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "El correo ingresado no existe",
              style: TextStyle(color: kSecondaryColor)),
          backgroundColor: kPrimaryColor,
        ));
       }else{
         Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return new ResetPasswordPage();
          }), (Route<dynamic> route) => false);
       }
     }else{
       _forgotPassKey.currentState!.validate();
     }

  }
}
