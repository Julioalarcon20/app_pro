import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api.dart';
import '../../widgets/widgets.dart';
import '../../app_styles.dart';
import '../../widgets/profile_widget.dart';
import '../../validators.dart';
import '../pages.dart';
import 'package:image_picker/image_picker.dart';

class EditarScreen extends StatefulWidget {
  const EditarScreen({Key? key}) : super(key: key);

  @override
  State<EditarScreen> createState() => _EditarScreenState();
}

class _EditarScreenState extends State<EditarScreen> {
  final _signUpKey = GlobalKey<FormState>();
  XFile? image;
  String imageBase64 = "";
  TextEditingController firstNameController = TextEditingController();
  TextEditingController ApellidoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  @override
  var userData;
  void initState() {
    _getUserInfo();
    super.initState();
    _signUpFocusNodes.forEach((element) {
      element.addListener(() {
        setState(() {});
      });
    });
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var leer = localStorage.getString('user');
    var user = json.decode(leer!);
    setState(() {
      userData = user;
      firstNameController.text = '${userData['Nombre']}';
      ApellidoController.text = '${userData['Apellido']}';
      emailController.text = '${userData['email']}';
      telefonoController.text = '${userData['telefono']}';
    });
  }

  final List<FocusNode> _signUpFocusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          GestureDetector(
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              image = await _picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                final bytes = File(image!.path).readAsBytesSync();
                imageBase64 = base64Encode(bytes);
              }
              setState(() {});
            },
            child: image == null
                ? ProfileWidget(
                    imagePath:
                        'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
                    onClicked: () async {},
                  )
                : Center(
                    child: Stack(children: [
                    ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: Image.file(
                          File(image!.path),
                          fit: BoxFit.cover,
                          width: 128,
                          height: 128,
                        ),
                      ),
                    ),
                  ])),
          ),
          const SizedBox(height: 24),
          Form(
            key: _signUpKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Nombre",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: kSecondaryColor,
                    )),
                const SizedBox(height: 8),
                MyTextFormUser(
                  controller: firstNameController,
                  fillColor: ktercero,
                  hint: 'Nombre',
                  icon: Icons.person,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.name,
                  focusNode: _signUpFocusNodes[0],
                  validator: nameValidator,
                ),
                const SizedBox(height: 15),
                const Text("Apellido",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: kSecondaryColor,
                    )),
                const SizedBox(height: 8),
                MyTextFormUser(
                  controller: ApellidoController,
                  fillColor: ktercero,
                  hint: 'Apellido',
                  icon: Icons.person,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.name,
                  focusNode: _signUpFocusNodes[1],
                  validator: nameValidator,
                ),
                const SizedBox(height: 15),
                const Text("Email",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: kSecondaryColor,
                    )),
                const SizedBox(height: 8),
                MyTextFormUser(
                  controller: emailController,
                  fillColor: ktercero,
                  hint: 'Email',
                  icon: Icons.email,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.name,
                  focusNode: _signUpFocusNodes[2],
                  validator: nameValidator,
                ),
                const SizedBox(height: 15),
                const Text("Teléfono",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: kSecondaryColor,
                    )),
                const SizedBox(height: 8),
                MyTextFormUser(
                  controller: telefonoController,
                  fillColor: Color(0xff201753),
                  hint: 'Teléfono',
                  icon: Icons.phone,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.name,
                  focusNode: _signUpFocusNodes[3],
                  validator: nameValidator,
                ),
                MyTextButton(
                  buttonName: 'Actalizar',
                  onPressed: Actualizar,
                  bgColor: kPrimaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Actualizar() async {
    var data = {
      'Nombre': firstNameController.text,
      'Apellido': ApellidoController.text,
      'email': emailController.text,
      'telefono': telefonoController.text,
      // 'img_perfil': imageBase64,
    };
    var _iduser = '${userData['id']}';

    var res = await CallApi().putData(data, 'actualizar/', _iduser);
    var body = json.decode(res.body);
    if (body['success']) {
      var actualizar = await CallApi().getData('perfil');
      var body = json.decode(actualizar.body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Home()));
    }
  }
}
