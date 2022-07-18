import 'package:flutter/material.dart';
import 'package:maxqui_shop/util/user.dart';
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
  User usuario = User();

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var leer = localStorage.getString('user');
    var user = json.decode(leer!);
    setState(() {
      usuario = User.fromJson(user);
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
              usuario != null ? '${usuario.nombre}' : '',
            ),
            accountEmail: Text(
              usuario != null ? '${usuario.email}' : '',
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  usuario.img != null
                      ? servidor + '${usuario.img}'
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
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home())),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text('Perfil', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PerfilScreen())),
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
                MaterialPageRoute(
                    builder: (context) => const ActualizarPasswordPage())),
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
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) {
        return LoginPage();
      }), (Route<dynamic> route) => false);
      ;
    }
  }
}
