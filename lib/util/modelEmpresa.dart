import 'package:maxqui_shop/util/modellink.dart';

class Empresa {
  int? id;
  String? Nombre_empre;
  String? description;
  String? ubicacion;
  String? telefono;
  String? logo;
  Urls? urls;
  Empresa(
      {this.id,
      this.Nombre_empre,
      this.logo,
      this.telefono,
      this.urls,
      this.description,
      this.ubicacion});
  factory Empresa.fromJson(Map<String, dynamic> json) {
    return Empresa(
      id: json['id'],
      Nombre_empre: json['Nombre_empre'],
      logo:json['img_avatar'],
      telefono: json['telefono'],
      description: json['Descripcion_empren'],
      ubicacion: json['Direccion_emp'],
      urls: Urls(
        id: json['link_us']['id'],
        instagram: json['link_us']['instagram'],
        web: json['link_us']['web'],
        facebook: json['link_us']['facebook'],
      ),
    );
  }
}
