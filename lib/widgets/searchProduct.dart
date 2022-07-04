import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../api/api.dart';
import '../app_styles.dart';
import '../model/apirespuesta.dart';
import '../util/modelProduct.dart';
import '../views/productos/detalle.dart';

class ProductosSearchDelegate extends SearchDelegate {
  @override
  final String searchFieldLabel;

  ProductosSearchDelegate(this.searchFieldLabel);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = "",
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    String? error;
    if (query.trim().isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Debes ingresar el Nombre del producto',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    List<dynamic> searchList = [];
    Future<void> ListSearch() async {
      ApiRespuesta res = await CallApi().getBuscarProductos('buscar/', query);
      if (res.error == null) {
        searchList = res.data as List<dynamic>;
      } else {
        error = res.error;
      }
    }

    return FutureBuilder(
      future: ListSearch(),
      builder: (context, AsyncSnapshot snaphot) {
        if (error != null) {
          return const Center(
              child: Text("No existe Productos con ese nombre",
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold)));
        }
        if (searchList.isNotEmpty) {
          return ListView.builder(
              itemCount: searchList.length,
              itemBuilder: (BuildContext context, int index) {
                Product lista = searchList[index];
                return _mostrarBusqueda(
                    img: servidor + lista.url!,
                    nombre: lista.nombre!,
                    precio: lista.precio?.toStringAsFixed(2),
                    pass: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => detalleProducto(lista)),
                      );
                    });
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: kPrimaryColor,
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('Realizar busqueda de productos',
          style: TextStyle(color: kSecondaryColor)),
    );
  }
}

@override
class _mostrarBusqueda extends StatelessWidget {
  const _mostrarBusqueda(
      {required this.nombre,
      required this.pass,
      required this.precio,
      required this.img});
  final String nombre, img;
  final precio;
  final GestureDragCancelCallback pass;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(img),
        title: Text(nombre, style: const TextStyle(color: kSecondaryColor)),
        trailing: Text(precio, style: const TextStyle(color: kPrimaryColor)),
        onTap: pass,
      ),
    );
  }
}
