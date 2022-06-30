import 'package:flutter/material.dart';

import '../../api/api.dart';
import '../../app_styles.dart';
import '../../model/apirespuesta.dart';
import '../../size_configs.dart';
import '../../util/modelProduct.dart';
import '../home_comp/search_field.dart';
import 'detalle.dart';

class Productos extends StatefulWidget {
  int id;
  String nombre_c;
  Productos(this.id, this.nombre_c, {Key? key}) : super(key: key);

  @override
  State<Productos> createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
  List<dynamic> productosList = [];

  Future<void> mostrarProductos() async {
    ApiRespuesta res =
        await CallApi().getProductos('productos/', '${widget.id}');
    if (res.error == null) {
      setState(() {
        productosList = res.data as List<dynamic>;
      });
    }
  }

  @override
  void initState() {
    mostrarProductos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = SizeConfig.blockSizeV!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.nombre_c),
        elevation: 0,
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: CircleAvatar(
            backgroundColor: kPrimaryColor.withOpacity(0.2),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: kSecondaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Row(
                children: const [
                  Expanded(
                    child: SearchField(),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                "Todos los productos",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: productosList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Product items = productosList[index];
                    return Container(
                      height: 170,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: ktercero,
                          borderRadius: BorderRadius.circular(15)),
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          Container(
                            height: 160,
                            width: 150,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: kScaffoldBackground,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(servidor + '${items.url}')),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '${items.nombre}',
                                  style: const TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  maxLines: 1,
                                ),
                                Text(
                                  '\$ ${items.precio?.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: getProportionateScreenWidth(15),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    detalleProducto(items)),
                                          );
                                        },
                                        child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: kPrimaryColor,
                                          ),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "Ver más",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
