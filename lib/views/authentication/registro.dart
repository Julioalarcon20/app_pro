// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:maxqui_shop/views/pages.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:maxqui_shop/api/api.dart';

// class SignUp extends StatefulWidget {
//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController mailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController passwordCController = TextEditingController();

//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Stack(
//           children: <Widget>[
//             /////////////  background/////////////
//             new Container(
//               decoration: new BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   stops: [0.0, 0.4, 0.9],
//                   colors: [
//                     Color(0xFFFF835F),
//                     Color(0xFFFC663C),
//                     Color(0xFFFF3F1A),
//                   ],
//                 ),
//               ),
//             ),

//             Positioned(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Card(
//                       elevation: 4.0,
//                       color: Colors.white,
//                       margin: EdgeInsets.only(left: 20, right: 20),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15)),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             /////////////// name////////////

//                             TextField(
//                               style: TextStyle(color: Color(0xFF000000)),
//                               controller: firstNameController,
//                               cursorColor: Color(0xFF9b9b9b),
//                               keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                 prefixIcon: Icon(
//                                   Icons.account_circle,
//                                   color: Colors.grey,
//                                 ),
//                                 hintText: "Nombre",
//                                 hintStyle: TextStyle(
//                                     color: Color(0xFF9b9b9b),
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.normal),
//                               ),
//                             ),
//                             TextField(
//                               style: TextStyle(color: Color(0xFF000000)),
//                               controller: mailController,
//                               cursorColor: Color(0xFF9b9b9b),
//                               keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                 prefixIcon: Icon(
//                                   Icons.account_circle,
//                                   color: Colors.grey,
//                                 ),
//                                 hintText: "Email",
//                                 hintStyle: TextStyle(
//                                     color: Color(0xFF9b9b9b),
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.normal),
//                               ),
//                             ),

//                             /////////////// Email ////////////

//                             TextField(
//                               style: TextStyle(color: Color(0xFF000000)),
//                               controller: passwordController,
//                               cursorColor: Color(0xFF9b9b9b),
//                               keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                 prefixIcon: Icon(
//                                   Icons.mail,
//                                   color: Colors.grey,
//                                 ),
//                                 hintText: "Contraseña ",
//                                 hintStyle: TextStyle(
//                                     color: Color(0xFF9b9b9b),
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.normal),
//                               ),
//                             ),

//                             /////////////// password ////////////

//                             TextField(
//                               style: TextStyle(color: Color(0xFF000000)),
//                               cursorColor: Color(0xFF9b9b9b),
//                               controller: passwordCController,
//                               keyboardType: TextInputType.text,
//                               obscureText: true,
//                               decoration: InputDecoration(
//                                 prefixIcon: Icon(
//                                   Icons.vpn_key,
//                                   color: Colors.grey,
//                                 ),
//                                 hintText: "Contraseña verificación",
//                                 hintStyle: TextStyle(
//                                     color: Color(0xFF9b9b9b),
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.normal),
//                               ),
//                             ),
//                             /////////////// SignUp Button ////////////
//                             Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: FlatButton(
//                                   child: Padding(
//                                     padding: EdgeInsets.only(
//                                         top: 8, bottom: 8, left: 10, right: 10),
//                                     child: Text(
//                                       _isLoading
//                                           ? 'Creating...'
//                                           : 'Create account',
//                                       textDirection: TextDirection.ltr,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 15.0,
//                                         decoration: TextDecoration.none,
//                                         fontWeight: FontWeight.normal,
//                                       ),
//                                     ),
//                                   ),
//                                   color: Colors.red,
//                                   disabledColor: Colors.grey,
//                                   shape: new RoundedRectangleBorder(
//                                       borderRadius:
//                                           new BorderRadius.circular(20.0)),
//                                   onPressed: _isLoading ? null : _handleLogin),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     /////////////// already have an account ////////////
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20),
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               new MaterialPageRoute(
//                                   builder: (context) => LoginPage()));
//                         },
//                         child: Text(
//                           'Already have an Account',
//                           textDirection: TextDirection.ltr,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 15.0,
//                             decoration: TextDecoration.none,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ]
//         ),
  
//       ),
//     );
//   }

//   void _handleLogin() async {
//     setState(() {
//       _isLoading = true;
//     });

//     var data = {
//       'Nombre': firstNameController.text,
//       'email': mailController.text,
//       'password': passwordController.text,
//       'password_confirmation': passwordController.text,
//     };

//     var res = await CallApi().postData(data, 'registro');
//     var body = json.decode(res.body);
//     if (body['success']) {
//       SharedPreferences localStorage = await SharedPreferences.getInstance();
//       localStorage.setString('token', body['access_token']);
//       // localStorage.setString('access_token', body['access_token']);
//       // // localStorage.setString('user', json.encode(body['user']));

//       Navigator.push(
//           context, new MaterialPageRoute(builder: (context) => Home()));
//     }

//     setState(() {
//       _isLoading = false;
//     });
//   }
// }