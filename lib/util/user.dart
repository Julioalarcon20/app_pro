class User {
  int? id;
  String? nombre;
  String? apellido;
  String? telefono;
  String? email;
  String? img;

  User({
    this.id,
    this.nombre,
    this.apellido,
    this.telefono,
    this.email,
    this.img,
  });

  //map json to category model
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nombre: json['Nombre'],
      apellido: json['Apellido'],
      telefono: json['telefono'],
      email: json['email'],
      img: json['img_perfil'],
    );
  }
}
