import 'package:flutter/material.dart';

import '../api/api.dart';
import '../app_styles.dart';
import '../model/apirespuesta.dart';
import '../util/modelOffer.dart';
import '../views/ofertas/detallesOfertas.dart';
import '../views/productos/detalle.dart';

class OfertasSearchDelegate extends SearchDelegate {
  @override
  final String searchFieldLabel;

  OfertasSearchDelegate(this.searchFieldLabel);
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
      ApiRespuesta res =
          await CallApi().getBuscarOfertas('buscarOfertas/', query);
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
            child: Text(
              "No existe Productos con ese nombre",
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
          );
        }
        if (searchList.isNotEmpty) {
          return ListView.builder(
              itemCount: searchList.length,
              itemBuilder: (BuildContext context, int index) {
                Offer items = searchList[index];
                return _mostrarBusqueda(
                    img: servidor + items.url!,
                    nombre: items.nombre!,
                    precio: items.precio?.toStringAsFixed(2),
                    pass: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => detalleOfertas(items)),
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
      child: Text('Realizar busqueda de productos en oferta',
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
