class Usuario {
  int? id;
  String? nombre;
  String? apellido;
  String? correo;
  String? img;
  String? telefono;
  String? token;
  Usuario({
    this.id,
    this.nombre,
    this.apellido,
    this.correo,
    this.img,
    this.telefono,
    this.token,
  });
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['user']['id'],
      nombre: json['user']['Nombre'],
      apellido: json['user']['Apellido'],
      correo: json['user']['email'],
      img: json['user']['img_perfil'],
      telefono: json['user']['telefono'],
      token: json['token'],
    );
  }
}
