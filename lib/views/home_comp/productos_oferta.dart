import 'package:flutter/material.dart';
import 'package:maxqui_shop/api/api.dart';
import 'package:maxqui_shop/model/apirespuesta.dart';
import 'package:maxqui_shop/views/home_comp/section_titulos.dart';

import '../../app_styles.dart';
import '../../size_configs.dart';
import '../../util/modelOffer.dart';

class OfertaScreen extends StatefulWidget {
  const OfertaScreen({Key? key}) : super(key: key);

  @override
  _OfertasState createState() => _OfertasState();
}

class _OfertasState extends State<OfertaScreen> {
  List<dynamic> ofertaList = [];

  Future<void> mostrarOfertas() async {
    ApiRespuesta res = await CallApi().getPromocion('ofertas');
    print(res.data);
    if (res.error == null) {
      setState(() {
        ofertaList = res.data as List<dynamic>;
      });
    }
  }

  @override
  void initState() {
    mostrarOfertas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SecionTitulo(
          titulo: "Productos en oferta",
          press: () {},
        ),
      ),
      SizedBox(height: getProportionateScreenWidth(20)),
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ofertaList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Offer oferta = ofertaList[index];
                    return OfertasCard(
                      titulo1: '${oferta.nombre}',
                      precio: '\$ ${oferta.precio}',
                      promocion: '${oferta.promocion}\%',
                      // descripcion: '${oferta.description}',
                      pass: () {},
                    );
                  }),
            )
          ],
        ),
      )
    ]);
  }
}

class OfertasCard extends StatelessWidget {
  const OfertasCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.titulo1,
    // required this.url,
    // required this.id,
    required this.precio,
    required this.promocion,
    // required this.descripcion,
    required this.pass,
  }) : super(key: key);
  final double width, aspectRetio;
  // final int id;
  final String titulo1, precio, promocion;
  final GestureDragCancelCallback pass;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
      ),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
            onTap: () => pass,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.02,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    //img_Productos
                    // child: Hero(
                    //   tag: id,
                    //   child: Image.network(url),
                    // ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$titulo1',
                  style: TextStyle(color: kSecondaryColor),
                  maxLines: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${precio}',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                    Text(
                      '$promocion',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
