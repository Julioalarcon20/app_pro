import 'package:flutter/material.dart';
import 'package:maxqui_shop/views/ofertas/perfilE.dart';
import '../../util/modelOffer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

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
            padding: const EdgeInsets.all(10),
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
                Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        '${widget.oferta.promocion}%',
                        style: const TextStyle(
                          color: kSecondaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
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
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Emprendimiento: ',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(15),
                              letterSpacing: 1,
                              height: 1.4,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.oferta.empresa?.Nombre_empre}',
                              style: TextStyle(
                                color: kSecondaryColor,
                                fontSize: getProportionateScreenWidth(15),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PerfilE(widget.oferta)),
                                  );
                                },
                                child: const Text(
                                  "Ver Perfil",
                                  style: TextStyle(color: kPrimaryColor),
                                ))
                          ])
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Oferta Valida hasta: ',
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
                            '${widget.oferta.fecha}',
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
          ),

          //Divide la descripcion del producto del precio y el boton de comprar
          const Divider(
            color: kPrimaryColor,
            thickness: 0.7,
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
                    "Precio : \$${widget.oferta.precio!.toStringAsFixed(2)}",
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
                      phoneNumber: '${widget.oferta.empresa?.telefono}',
                      text: "Producto: ${widget.oferta.nombre}" +
                          "\n Precio: \$${widget.oferta.precio?.toStringAsFixed(2)}" +
                          "\n Vi esto en MaxquiShpo",
                    );
                    await launch('$link');
                  },
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.all(10),
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
