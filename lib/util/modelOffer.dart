class Offer {
  num? id;
  String? nombre;
  String? description;
  // bool? activo;
  num? precio;
  int? promocion;
  // int? id_categoria;

  Offer({
    this.id,
    this.nombre,
    this.description,
    // this.activo,
    this.precio,
    this.promocion,
    // this.id_categoria,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      nombre: json['Nombre'],
      description: json['Descripcion'],
      // activo:json['Activo'],
      precio: json['Precio'],
      promocion: json['promocion'],
      // id_categoria:json['id_ca'],
    );
  }
}
