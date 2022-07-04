import 'modelEmpresa.dart';

class Product {
  int? id;
  String? nombre;
  String? description;
  num? precio;
  String? url;
  Empresa? empresa;

  Product({this.id, this.nombre, this.description, this.precio, this.url,this.empresa});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nombre: json['Nombre'],
      description: json['Descripcion'],
      precio: json['Precio'],
      url: json['url_productos'],
      empresa:Empresa(
        Nombre_empre: json['negocio']['Nombre_empre'],
        telefono:json['negocio']['telefono'],
      ),
    );
  }

  static fromJSON(e) {}
}
