import 'package:flutter/material.dart';
import 'package:maxqui_shop/views/home_comp/search_field.dart';
import '../../Nav.dart';
import '../../size_configs.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:const [
          SearchField(),
        ]
      ),
    );
  }
}
