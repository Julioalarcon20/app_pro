class Category{
  int? id;
  String? nombrecategorias;
  String? imgcategorias;

  Category({
    this.id,
    this.nombrecategorias,
    this.imgcategorias,
  });

  //map json to category model
  factory Category.fromJson(Map<String, dynamic>json){
    return Category(
      id:json['id'],
      nombrecategorias:json['nombre_categorias'],
      imgcategorias:json['img_categorias'],
    );
  }
}
