import 'package:flutter/material.dart';
import 'package:maxqui_shop/views/home_comp/categoria.dart';
import 'package:maxqui_shop/views/home_comp/productos_oferta.dart';
import '../../size_configs.dart';
import 'banner.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: getProportionateScreenWidth(20)),
          const BannerScreen(),
          const CategoriaScreen(),
          SizedBox(height: getProportionateScreenWidth(30)),
          const OfertaScreen(),
          SizedBox(height: getProportionateScreenWidth(10)),
        ]),
      ),
    );
  }
}
