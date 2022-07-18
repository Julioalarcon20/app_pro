import 'package:flutter/material.dart';
import 'package:maxqui_shop/util/modelOffer.dart';

import '../../api/api.dart';
import '../../app_styles.dart';
import '../../model/apirespuesta.dart';
import '../../size_configs.dart';
import '../../widgets/searchOfertas.dart';
import 'detallesOfertas.dart';

class OfertasListas extends StatefulWidget {
  OfertasListas({Key? key}) : super(key: key);

  @override
  State<OfertasListas> createState() => _OfertasState();
}

class _OfertasState extends State<OfertasListas> {
  List<dynamic> ofertasList = [];
  String? error;
  late bool _isLoading;

  Future<void> mostrarOfertas() async {
    _isLoading = true;
    ApiRespuesta res = await CallApi().getListaPromocion('listaOfertas');
    if (res.error == null) {
      setState(() {
        ofertasList = res.data as List<dynamic>;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Lista de ofertas"),
        elevation: 0,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: OfertasSearchDelegate('Buscar...'),
                );
              },
              icon: const Icon(Icons.search, color: Colors.white))
        ],
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
              const Text(
                "Todos los Ofertas Disponibles",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
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
                            itemCount: ofertasList.length,
                            itemBuilder: (BuildContext context, int index) {
                              Offer items = ofertasList[index];
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
                                            image: NetworkImage(
                                                servidor + '${items.url}')),
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
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
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      15),
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
                                                              detalleOfertas(
                                                                  items)),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
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
