import 'package:flutter/material.dart';

import '../../Nav.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../api/api.dart';
import '../../app_styles.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../util/modelEmpresa.dart';
import '../../util/modelOffer.dart';
import '../../widgets/img_perfil.dart';

class PerfilE extends StatefulWidget {
  Offer id_empresa;
  PerfilE(this.id_empresa, {Key? key}) : super(key: key);
  @override
  State<PerfilE> createState() => _PerfilEmpresaState();
}

class _PerfilEmpresaState extends State<PerfilE> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.id_empresa.empresa?.urls?.instagram);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      drawer: NavBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Profile_emWidget(
              imagePath: widget.id_empresa.empresa?.logo == null
                  ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
                  : servidor + "${widget.id_empresa.empresa?.logo}"),
          const SizedBox(height: 26),
          Container(
            height: 490,
            decoration: const BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: buildAbout(),
          ),
        ],
      ),
    );
  }

  Widget buildAbout() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Align(
              child: Text(
                '${widget.id_empresa.empresa?.Nombre_empre}',
                style: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Mulish'),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              "Detalle del Negocio:",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aleo'),
            ),
            const SizedBox(height: 20),
            Text(
              '${widget.id_empresa.empresa?.description}',
              style: const TextStyle(
                color: ktercero,
                fontSize: 18,
                fontWeight: FontWeight.normal,
                fontFamily: 'Aleo',
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              "Numero de Contacto:",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aleo'),
            ),
            const SizedBox(height: 20),
            Text(
              "${widget.id_empresa.empresa?.telefono}",
              style: const TextStyle(
                color: ktercero,
                fontSize: 18,
                fontWeight: FontWeight.normal,
                fontFamily: 'Aleo',
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              "Direccion:",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aleo'),
            ),
            const SizedBox(height: 20),
            Text(
              "${widget.id_empresa.empresa?.ubicacion}",
              style: const TextStyle(
                color: ktercero,
                fontSize: 18,
                fontWeight: FontWeight.normal,
                fontFamily: 'Aleo',
              ),
            ),
            const SizedBox(height: 20),
            const Center(
                child: Text(
              "Redes Sociales",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Aleo',
              ),
            )),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.facebook,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 30,
                    ),
                    onPressed: () async {
                      if (widget.id_empresa.empresa?.urls?.facebook != null) {
                        final facebook =
                            "${widget.id_empresa.empresa?.urls?.facebook}";
                        await launch(facebook);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              "Este perfil no cuenta con una cuenta de facebook",
                              style: TextStyle(color: kSecondaryColor)),
                          backgroundColor: kPrimaryColor,
                        ));
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.web,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 30,
                    ),
                    onPressed: () async {
                      if (widget.id_empresa.empresa?.urls?.web != null) {
                        final facebook =
                            "${widget.id_empresa.empresa?.urls?.web}";
                        await launch(facebook);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              "Este perfil no cuenta con una pagina web",
                              style: TextStyle(color: kSecondaryColor)),
                          backgroundColor: kPrimaryColor,
                        ));
                      }
                    },
                  ),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.instagram,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 30,
                    ),
                    onPressed: () async {
                      if (widget.id_empresa.empresa?.urls?.instagram != null) {
                        final facebook =
                            "${widget.id_empresa.empresa?.urls?.instagram}";
                        await launch(facebook);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              "Este perfil no cuenta con una cuenta de instagram",
                              style: TextStyle(color: kSecondaryColor)),
                          backgroundColor: kPrimaryColor,
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
