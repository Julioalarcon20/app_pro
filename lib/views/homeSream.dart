import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:maxqui_shop/Nav.dart';

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
        onPressed: () {},
      ),
      backgroundColor: Colors.black,
    );
  }
}
  // void logout() async {
  //   // logout from the server ...
  //   var res = await CallApi().getData('logout');
  //   var body = json.decode(res.body);
  //   if (body['success']) {
  //     SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     localStorage.remove('user');
  //     localStorage.remove('token');
  //    Navigator.push(
  //       context, new MaterialPageRoute(builder: (context) => LoginPage()));
  //  }
  // }

=======
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
>>>>>>> 757790e2ccbeccbe332e22bad61afdaba8ef2d5f
