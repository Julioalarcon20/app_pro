class Urls {
  int? id;

  String? instagram;
  String? web;
  String? facebook;
  Urls({
    this.id,
    this.instagram,
    this.web,
    this.facebook,
  });
  factory Urls.fromJson(Map<String, dynamic> json) {
    return Urls(
      instagram:json['instagram'],
      web:json[' web'],
      facebook:json['facebook'],
    ); 
  }
}         
