import 'package:flutter/material.dart';
import '../../app_styles.dart';
import '../../size_configs.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(getProportionateScreenWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(15),
      ),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text.rich(
        TextSpan(
          style: TextStyle(color: kScaffoldBackground),
          children: [
            TextSpan(
              text:
                  "Una manera facil de encontrar productos de los emprendedores de Pomasqui",
            ),
          ],
        ),
      ),
    );
  }
}
