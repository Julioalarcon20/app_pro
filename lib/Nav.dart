import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maxqui_shop/views/pages.dart';
import 'package:maxqui_shop/api/api.dart';
import 'dart:convert';
import './app_styles.dart';

class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var userData;

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var leer = localStorage.getString('user');
    var user = json.decode(leer!);
    setState(() {
      userData = user;
    });
  }

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kScaffoldBackground,
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              userData != null ? '${userData['Nombre']}' : '',
            ),
            accountEmail: Text(
              userData != null ? '${userData['email']}' : '',
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  userData != null
                      ? '${userData['img_perfil']}'
                      : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: kScaffoldBackground,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2016/06/02/02/33/triangles-1430105_960_720.png'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.white),
            title: Text('Perfil', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.push(context,
                new MaterialPageRoute(builder: (context) => PerfilScreen())),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.password_outlined, color: Colors.white),
            title: const Text(
              'Cambio de Contraseña',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => ActualizarPasswordPage())),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.white),
            title: const Text('Sobre la aplicación',
                style: TextStyle(color: Colors.white)),
            onTap: () => null,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.white),
            title: const Text('Cerrar Sesión',
                style: TextStyle(color: Colors.white)),
            onTap: () => {logout()},
          ),
        ],
      ),
    );
  }

  void logout() async {
    // logout from the server ...
    var res = await CallApi().getData('logout');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('access_token');
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}
