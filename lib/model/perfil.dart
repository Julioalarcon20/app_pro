class cliente {
  final String nombre;
  final String apellido;
  final String email;
  final String telefono;
  cliente({
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.telefono,
  });
  factory cliente.fromJson(Map<String, dynamic> json) {
    return cliente(
      nombre: json['Nombre'],
      apellido: json['Apellido'],
      email: json['email'],
      telefono: json['telefono'],
    );
  }
}
