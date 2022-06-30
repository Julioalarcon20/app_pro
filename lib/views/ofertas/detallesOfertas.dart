import 'package:flutter/material.dart';
import '../../util/modelOffer.dart';

import '../../api/api.dart';
import '../../app_styles.dart';
import '../../size_configs.dart';

class detalleOfertas extends StatefulWidget {
  Offer oferta;
  detalleOfertas(this.oferta, {Key? key}) : super(key: key);

  @override
  State<detalleOfertas> createState() => _detalleOfertasState();
}

class _detalleOfertasState extends State<detalleOfertas> {
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
                          image:
                              NetworkImage(servidor + '${widget.oferta.url}'),
                        )),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${widget.oferta.nombre}',
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
          Container(
            child: Expanded(
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
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${widget.oferta.description}',
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
              ),
            ),
          ),

          //Divide la descripcion del producto del precio y el boton de comprar
          const Divider(
            color: kPrimaryColor,
            thickness: 0.7,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    "Precio : \$${widget.oferta.precio!.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: kSecondaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    "Pedir",
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
