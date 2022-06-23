class Category{
  int? id;
  String? nombre_categorias;
  String? img_categorias;

  Category({
    this.id,
    this.nombre_categorias,
    this.img_categorias,
  });

  //map json to category model
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id:json['id'],
      nombre_categorias:json['nombre_categorias'],
      img_categorias:json['img_categorias'],
    );
  }
}
