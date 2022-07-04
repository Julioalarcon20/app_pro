import 'package:flutter/material.dart';
import 'package:maxqui_shop/Nav.dart';
import 'package:maxqui_shop/views/home_comp/body.dart';

import '../util/modelProduct.dart';
import '../widgets/searchProduct.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }

  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> historia = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ProductosSearchDelegate('Buscar...'),
                );
              },
              icon: const Icon(Icons.search, color: Colors.white))
        ],
      ),
      drawer: NavBar(),
      body: const Body(),
    );
  }
}
