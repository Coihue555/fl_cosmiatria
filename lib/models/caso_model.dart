class CasoModel {
  String? uid;
  final String nombre;
  final String usuario;
  final String fechaCaso;
  final String observaciones;
  final List<String> lstImagenes;
  final Map<String, dynamic> data;

  CasoModel({
    this.uid,
    this.nombre = '',
    this.usuario = '',
    this.fechaCaso = '',
    this.observaciones = '',
    this.lstImagenes = const [''],
    Map<String, dynamic>? data,
  }) : data = data ?? {};

  //TODO hacer el copyWith

  // From JSON
  factory CasoModel.fromJson(Map<String, dynamic> json) {
    return CasoModel(
      uid: (json.containsKey("uid")) ? json["uid"].toString() : '',
      data: json,
      usuario: (json.containsKey("usuario")) ? json["usuario"].toString() : '',
      nombre: (json.containsKey("nombre")) ? json['nombre'].toString() : '',
      fechaCaso: (json.containsKey("fechaCaso")) ? json['fechaCaso'].toString() : '',
      observaciones: (json.containsKey("observaciones")) ? json['observaciones'].toString() : '',
      lstImagenes: (json.containsKey("lstImagenes")) ? List<String>.from(json['lstImagenes']) : List<String>.from([]),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'data': data,
      'usuario': usuario,
      'nombre': nombre,
      'fechaCaso': fechaCaso,
      'observaciones': observaciones,
      'lstImagenes': lstImagenes,
    };
  }
}
