import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maxqui_shop/views/pages.dart';
import 'package:maxqui_shop/api/api.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Larry K. Pinga'),
            accountEmail: Text('Skarlet@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil',style: TextStyle(color:Colors.black)),
            onTap: () => null,
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Opciones',style: TextStyle(color:Colors.black),),
            onTap: () => null,
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Sobre la aplicación',style: TextStyle(color:Colors.black)),
            onTap: () => null,
          ),
          const Divider(),
          ListTile(
            title: Text('Salir',style: TextStyle(color:Colors.black)),
            leading: Icon(Icons.exit_to_app),
            onTap: ()=> null
          ),
        ],
      ),
    );
  }
}
