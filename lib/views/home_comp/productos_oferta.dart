import 'package:flutter/material.dart';
import 'package:maxqui_shop/views/home_comp/section_titulos.dart';
import '../../size_configs.dart';
import '../../util/modelOfertas.dart';

class ProductosOferta extends StatefulWidget {
  @override
  _ProductoState createState() => _ProductoState();
}

class _ProductoState extends State<ProductosOferta> {
  List<dynamic> promocionList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SecionTitulo(titulo: "Productos oferta", press: () {}),
      ),
      SizedBox(height: getProportionateScreenWidth(20)),
      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // children: [
            //   ...List.generate(
            //     promocionList.length,
            //     (index) {
            //       if (promocionList[index]!=null)
            //         return ProductoCard(product: promocionList[index]);
            //       return SizedBox
            //           .shrink(); // here by default width and height is 0
            //     },
            //   )
            // ],
          )),
    ]);
  }
}

// class ProductoCard extends StatefulWidget {
//   const ProductoCard(
//       {Key? key,
//       this.width = 140,
//       this.aspectRatio = 1.02,
//       required this.oferta})
//       : super(key: key);
//   final double width, aspectRatio;
//   final Oferta oferta;

// }
