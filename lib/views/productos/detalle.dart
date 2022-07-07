import 'package:flutter/material.dart';
import 'package:maxqui_shop/util/modelProduct.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../api/api.dart';
import '../../app_styles.dart';
import '../../size_configs.dart';

class detalleProducto extends StatefulWidget {
  Product items;
  detalleProducto(this.items, {Key? key}) : super(key: key);

  @override
  State<detalleProducto> createState() => _detalleProductoState();
}

class _detalleProductoState extends State<detalleProducto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 15,
              bottom: 15,
              left: 15,
              right: 15,
            ),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: kSecondaryColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                // Imagen principal del detalle de productos

                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(servidor + '${widget.items.url}'),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${widget.items.nombre}',
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: getProportionateScreenWidth(24),
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),

          //Texto de la descripcion del producto
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Descripcion del Producto:',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(15),
                        letterSpacing: 1,
                        height: 1.4,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${widget.items.description}',
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: getProportionateScreenWidth(14),
                        letterSpacing: 1,
                        height: 1.4,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Emprendimiento:',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(15),
                            letterSpacing: 1,
                            height: 1.4,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${widget.items.empresa?.Nombre_empre}',
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: getProportionateScreenWidth(14),
                            letterSpacing: 1,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //Divide la descripcion del producto del precio y el boton de comprar
          const Divider(
            color: kPrimaryColor,
            thickness: 0.5,
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    "Precio : \$${widget.items.precio!.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: kSecondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final link = WhatsAppUnilink(
                      phoneNumber: '${widget.items.empresa?.telefono}',
                      text: "Producto: ${widget.items.nombre}" +
                          "\n Precio: \$${widget.items.precio?.toStringAsFixed(2)}" +
                          "\n Vi esto en MaxquiShpo",
                    );
                    await launch('$link');
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      "Pedelo Ya!",
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
