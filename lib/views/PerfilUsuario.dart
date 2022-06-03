import 'package:flutter/material.dart';
import 'package:maxqui_shop/size_configs.dart';
import 'package:maxqui_shop/app_styles.dart';

class PerfilScreen extends StatefulWidget {
  PerfilScreen({Key? key}) : super(key: key);

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.4,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    Text('Mi Perfil', style: kTitle2),
                    ClipOval(
                      child: Image.asset(
                        '../../assets/image/perfil.png',
                        width: size.width * 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: size.height * 0.6,
              color: kSecondaryColor,
            )
          ],
        ),
      ),
    );
  }
}
