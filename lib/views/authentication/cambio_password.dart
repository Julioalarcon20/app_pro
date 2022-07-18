import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api.dart';
import '../../app_styles.dart';
import '../../size_configs.dart';
import '../../validators.dart';
import '../pages.dart';
import 'dart:convert';
import '../../widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActualizarPasswordPage extends StatefulWidget {
  const ActualizarPasswordPage({Key? key}) : super(key: key);

  @override
  _ActualizarPasswordPageState createState() => _ActualizarPasswordPageState();
}

class _ActualizarPasswordPageState extends State<ActualizarPasswordPage> {
  final _ActualizarPassKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final password = TextEditingController();

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
                      "¿Deseas actualizar tu contraseña?",
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
                        key: _ActualizarPassKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Una vez actualizada la contraseña el sistema cerrara la sesión",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyPasswordField(
                              controller: password,
                              hint: 'Nueva Contraseña',
                              fillColor: kScaffoldBackground,
                              focusNode: focusNode1,
                              validator: passwordValidator,
                            ),
                            MyTextButton(
                              buttonName:  _isLoading
                                  ? 'Cargando...'
                                  : 'Actualizar Contraseña',
                              onPressed: _ActualizarPass,
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

  _ActualizarPass() async {
    _ActualizarPassKey.currentState!.validate();
     setState(() {
      _isLoading = true;
    });
    var userData;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var leer = localStorage.getString('user');
    var user = json.decode(leer!);
    userData = user;
    var _iduser = '${userData['id']}';
    var data = {
      'password': password.text,
    };
    var res = await CallApi().putData(data, 'actualizar_password/', _iduser);
    var body = json.decode(res.body);
    if (body['success']) {
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => LoginPage()));
    }
     setState(() {
      _isLoading = false;
    });
  }
}
