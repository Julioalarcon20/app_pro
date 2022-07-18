import 'package:flutter/material.dart';
import 'package:maxqui_shop/api/api.dart';
import 'package:maxqui_shop/model/apirespuesta.dart';
import 'package:maxqui_shop/views/home_comp/section_titulos.dart';
import '../../app_styles.dart';
import '../../size_configs.dart';
import '../../util/modelOffer.dart';
import '../ofertas/detallesOfertas.dart';
import '../ofertas/listaOferta.dart';

class OfertaScreen extends StatefulWidget {
  const OfertaScreen({Key? key}) : super(key: key);

  @override
  _OfertasState createState() => _OfertasState();
}

class _OfertasState extends State<OfertaScreen> {
  List<dynamic> ofertaList = [];
  String? error;
  late bool _isLoading;

  Future<void> mostrarOfertas() async {
    _isLoading = true;
    ApiRespuesta res = await CallApi().getPromocion('ofertas');
    if (res.error == null) {
      setState(() {
        ofertaList = res.data as List<dynamic>;
      });
    } else {
      setState(() {
        error = res.error;
      });
    }
    _isLoading = false;
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
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OfertasListas()),
            );
          },
        ),
      ),
      SizedBox(height: getProportionateScreenWidth(20)),
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 210,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: kPrimaryColor,
                        ),
                      )
                    : error != null
                        ? const Center(
                            child: Text(
                              "No existe ninguna oferta",
                              style: TextStyle(
                                color: kSecondaryColor,
                              ),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: ofertaList.length,
                            itemBuilder: (BuildContext context, int index) {
                              Offer oferta = ofertaList[index];
                              return OfertasCard(
                                titulo1: '${oferta.nombre}',
                                url: servidor + "${oferta.url}",
                                precio:
                                    '\$ ${oferta.precio?.toStringAsFixed(2)}',
                                promocion: '${oferta.promocion}%',
                                pass: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          detalleOfertas(oferta),
                                    ),
                                  );
                                },
                              );
                            }))
          ],
        ),
      )
    ]);
  }
}

class OfertasCard extends StatelessWidget {
  const OfertasCard({
    Key? key,
    this.width = 150,
    this.aspectRetio = 1.02,
    required this.titulo1,
    required this.url,
    required this.precio,
    required this.promocion,
    required this.pass,
  }) : super(key: key);
  final double width, aspectRetio;
  final String titulo1, precio, promocion, url;
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
            onTap: pass,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.02,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // img_Productos
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  titulo1,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(14),
                    color: kSecondaryColor,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      precio,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      promocion,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                        fontWeight: FontWeight.bold,
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
