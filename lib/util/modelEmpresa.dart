class Empresa {
  int? id;
  String? Nombre_empre;
  String? telefono;
  Empresa({
    this.id,
    this.Nombre_empre,
    this.telefono,
  });
  factory Empresa.fromJson(Map<String, dynamic> json) {
    return Empresa(
      id: json['id'],
      Nombre_empre: json['Nombre_empre'],
      telefono: json['telefono'],
    );
  }
}
