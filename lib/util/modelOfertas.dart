class Oferta {
  int? id;
  String? titulo;
  double? precio;
  int? promocion;
  String? descripcion;
  Oferta({
    required this.id,
    required this.titulo,
    required this.precio,
    required this.promocion,
    required this.descripcion,
  });
  factory Oferta.fromJson(Map<String, dynamic> json) {
    return Oferta(
      id: json['id'],
      titulo: json['Nombre'],
      precio: json['PrecioDescripcion'],
      descripcion: json['Descripcion'],
      promocion: json['promocion'],
    );
  }
}
