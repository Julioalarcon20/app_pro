import 'package:flutter/material.dart';

import '../../app_styles.dart';
import '../../size_configs.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth! * 0.8,
      height: 50,
      decoration: BoxDecoration(
        color: ktercero,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        cursorColor: kSecondaryColor,
        onChanged: (value) => print(value),
        style: const TextStyle(
          color: kSecondaryColor,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Buscar Producto",
            fillColor: kSecondaryColor,
            hintStyle: TextStyle(
              fontSize: 17,
              color: kSecondaryColor.withOpacity(0.5),
            ),
            prefixIcon:
                const Icon(Icons.search, size: 20, color: kSecondaryColor)),
      ),
    );
  }
}
