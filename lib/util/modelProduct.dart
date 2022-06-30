class Product {
  int? id;
  String? nombre;
  String? description;
  num? precio;
  String? url;

  Product({this.id, this.nombre, this.description, this.precio, this.url});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nombre: json['Nombre'],
      description: json['Descripcion'],
      precio: json['Precio'],
      url: json['url_productos'],
    );
  }
}
