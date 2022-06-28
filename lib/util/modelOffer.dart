
class Offer {
  int? id;
  String? nombre;
  String? description;
  num? precio;
  int? promocion;
  int? id_categoria;
 String? url;

  Offer({
    this.id,
    this.nombre,
    this.description,
    this.precio,
    this.promocion,
    this.id_categoria,
    this.url,
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
    );
  }
}
