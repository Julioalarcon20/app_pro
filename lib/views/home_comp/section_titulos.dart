import 'package:flutter/material.dart';
import '../../app_styles.dart';
import '../../size_configs.dart';

class SecionTitulo extends StatelessWidget {
  const SecionTitulo({
    Key? key,
    required this.titulo,
    required this.press,
  }) : super(key: key);
  final String titulo;
  final GestureDragCancelCallback press;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        titulo,
        style: const TextStyle(
          color: kPrimaryColor,
        ),
      ),
      GestureDetector(
          onTap: press,
          child: const Text(
            "Ver más",
            style: TextStyle(color: kSecondaryColor),
          ))
    ]);
  }
}
