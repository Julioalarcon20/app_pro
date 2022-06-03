import 'package:flutter/material.dart';
import 'package:maxqui_shop/NavBar.dart';

class Home extends StatefulWidget {
  Home ({Key? key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      drawer: NavBar(),
      endDrawer: NavBar(),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {  },),
        backgroundColor: Colors.black,
    );
  }
}