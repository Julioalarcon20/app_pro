import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:maxqui_shop/app_styles.dart';
import 'package:maxqui_shop/Nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/profile_widget.dart';
import 'package:maxqui_shop/views/pages.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({Key? key}) : super(key: key);

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  var userData;
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var leer = localStorage.getString('user');
    var user = json.decode(leer!);
    setState(() {
      return userData = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      drawer: NavBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: userData != null ? '${userData['img_perfil']}' : '',
            onClicked: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditarScreen()),
              );
            },
          ),
          const SizedBox(height: 26),
          Container(
            height: 490,
            decoration: const BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: buildAbout(),
          ),
        ],
      ),
    );
  }

  Widget buildAbout() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const Align(
              child: Text(
                "Mi cuenta",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Mulish'),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              "Nombre:",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aleo'),
            ),
            const SizedBox(height: 20),
            Text(
              userData != null ? '${userData['Nombre']}' : '',
              style: const TextStyle(
                  color: ktercero,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Aleo',
                  fontSize: 22),
            ),
            const SizedBox(height: 22),
            const Text(
              "Apellido:",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aleo'),
            ),
            const SizedBox(height: 20),
            Text(
              userData != null ? '${userData['Apellido']}' : '',
              style: const TextStyle(
                  color: ktercero,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Aleo',
                  fontSize: 22),
            ),
            const SizedBox(height: 22),
            const Text(
              "Correo Electronico:",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aleo'),
            ),
            const SizedBox(height: 20),
            Text(
              userData != null ? '${userData['email']}' : '',
              style: const TextStyle(
                  color: ktercero,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Aleo',
                  fontSize: 22),
            ),
            const SizedBox(height: 22),
            const Text(
              "Teléfono:",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aleo'),
            ),
            const SizedBox(height: 20),
            Text(
              userData != null ? '${userData['telefono']}' : '',
              style: const TextStyle(
                  color: ktercero,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Aleo',
                  fontSize: 22),
            ),
          ],
        ),
      );
}
