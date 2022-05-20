import 'package:flutter/material.dart';
import '../utilidades/app.style.dart';

class PaginaBienvenidaWidget extends StatefulWidget {
  const PaginaBienvenidaWidget({Key? key}) : super(key: key);

  @override
  _PaginaBienvenidaWidgetState createState() => _PaginaBienvenidaWidgetState();
}

class _PaginaBienvenidaWidgetState extends State<PaginaBienvenidaWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E112E),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset('assets/image/primera.jpg',
                  width: 457, height: 487, fit: BoxFit.cover),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Text(
                        'Bienvenido',
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Aleo',
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                      child: Text(
                        'En esta plataforma encontraras productos innovadores',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Mulish',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                      child: TextButton(
                        child: Text(
                          'Hola',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          print('Boton funcionando');
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(252, 89, 57, 1),
                            ),
                            minimumSize: MaterialStateProperty.all(Size(200, 50),)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
