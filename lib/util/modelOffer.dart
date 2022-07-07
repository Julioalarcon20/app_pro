import 'modelEmpresa.dart';

class Offer {
  int? id;
  String? nombre;
  String? description;
  num? precio;
  int? promocion;
  int? id_categoria;
  String? url;
  String? fecha;
  Empresa? empresa;

  Offer({
    this.id,
    this.nombre,
    this.description,
    this.precio,
    this.promocion,
    this.id_categoria,
    this.url,
    this.fecha,
    this.empresa,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      nombre: json['Nombre'],
      description: json['Descripcion'],
      precio: json['Precio'],
      promocion: json['promocion'],
      id_categoria: json['id_ca'],
      url: json['url_ofertas'],
      fecha: json['fecha'],
      empresa: Empresa(
          Nombre_empre: json['negocio']['Nombre_empre'],
          telefono: json['negocio']['telefono'],
        )
    );
  }
}
