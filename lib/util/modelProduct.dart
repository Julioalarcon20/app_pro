import 'modelEmpresa.dart';
import 'modellink.dart';

class Product {
  int? id;
  String? nombre;
  String? description;
  num? precio;
  String? url;
  Empresa? empresa;
  Urls? urls;

  Product(
      {this.id,
      this.nombre,
      this.description,
      this.precio,
      this.url,
      this.empresa,
      this.urls});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nombre: json['Nombre'],
      description: json['Descripcion'],
      precio: json['Precio'],
      url: json['url_productos'],
      empresa: Empresa(
          id: json['negocio']['id'],
          Nombre_empre: json['negocio']['Nombre_empre'],
          logo: json['negocio']['img_avatar'],
          description: json['negocio']['Descripcion_empren'],
          ubicacion: json['negocio']['Direccion_emp'],
          telefono: json['negocio']['telefono'],
          urls: Urls(
            instagram: json['negocio']['link_us']['instagram'],
             web: json['negocio']['link_us']['web'],
            facebook: json['negocio']['link_us']['facebook'],
          )),
    );
  }

  static fromJSON(e) {}
}
