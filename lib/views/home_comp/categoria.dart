import 'package:flutter/material.dart';
import '../../app_styles.dart';
import '../../model/apirespuesta.dart';
import '../../size_configs.dart';
import '../../util/modelCategory.dart';
import '../../api/api.dart';
import '../productos/items.dart';

class CategoriaScreen extends StatefulWidget {
  const CategoriaScreen({Key? key}) : super(key: key);

  @override
  _CategoriasState createState() => _CategoriasState();
}

class _CategoriasState extends State<CategoriaScreen> {
  List<dynamic> categoriaList = [];

  Future<void> mostrarCategoria() async {
    ApiRespuesta res = await CallApi().getCategoria('categorias');
    if (res.error == null) {
      setState(() {
        categoriaList = res.data as List<dynamic>;
      });
    }
  }

  @override
  void initState() {
    mostrarCategoria();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Todas las categorias",
              style: TextStyle(
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: getProportionateScreenWidth(20)),
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriaList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Category categoria = categoriaList[index];
                    return CategoriaChildScrollView(
                      image: '${servidor}' + '${categoria.img_categorias}',
                      category: '${categoria.nombre_categorias}',
                      press: () {
                        String nombre_c = categoria.nombre_categorias!;
                        int id = categoria.id!;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Productos(id, nombre_c)),
                        );
                      },
                    );
                  }),
            )
          ],
        ),
      )
    ]);
  }
}

class CategoriaChildScrollView extends StatelessWidget {
  const CategoriaChildScrollView({
    Key? key,
    required this.category,
    required this.image,
    required this.press,
  }) : super(key: key);
  final String category, image;
  final GestureDragCancelCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(242),
          height: getProportionateScreenWidth(80),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Image.network(
                image,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.topCenter,
                    colors: [
                      const Color.fromARGB(255, 17, 17, 17).withOpacity(0.5),
                      const Color.fromARGB(255, 17, 17, 17).withOpacity(0.5),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10.0),
                  vertical: getProportionateScreenWidth(10),
                ),
                child: Text.rich(
                  TextSpan(
                      style: const TextStyle(color: kSecondaryColor),
                      children: [
                        TextSpan(
                          text: '$category',
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
