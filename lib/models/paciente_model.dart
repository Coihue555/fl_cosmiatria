class PacienteModel {
  String? uid;
  final String usuario;
  final String nombre;
  final String edad;
  final String tipoPiel;
  final String colorPiel;
  final String texturaPiel;
  final String brilloPiel;
  final String espesorPiel;
  final String turgenciaPiel;
  final String hidratacionPiel;
  final String observaciones1;
  final String sensibilidadPiel;
  final String observaciones2;
  final String orificiosSebaceos;
  final String observaciones3;
  final String parpados;
  final String observaciones4;
  final String pigmentacion;
  final String observaciones5;
  final String arrugas;
  final String observaciones6;
  final String flacidez;
  final String observaciones7;
  final String dermatosis;
  final List<String> tipoAcne;
  final String observaciones8;
  final List<String> lstImagenes;
  final Map<String, dynamic> data;

  PacienteModel({
    this.uid,
    this.edad = '',
    this.tipoPiel = '',
    this.colorPiel = '',
    this.texturaPiel = '',
    this.brilloPiel = '',
    this.espesorPiel = '',
    this.turgenciaPiel = '',
    this.hidratacionPiel = '',
    this.observaciones1 = '',
    this.sensibilidadPiel = '',
    this.observaciones2 = '',
    this.orificiosSebaceos = '',
    this.observaciones3 = '',
    this.parpados = '',
    this.observaciones4 = '',
    this.pigmentacion = '',
    this.observaciones5 = '',
    this.arrugas = '',
    this.observaciones6 = '',
    this.flacidez = '',
    this.observaciones7 = '',
    this.dermatosis = '',
    this.tipoAcne = const [''],
    this.observaciones8 = '',
    this.lstImagenes = const [''],
    this.usuario = '',
    this.nombre = '',
    Map<String, dynamic>? data,
  }) : data = data ?? {};

  PacienteModel copyWith({
    String? uid,
    Map<String, dynamic>? data,
    String? usuario,
    String? nombre,
    String? edad,
    String? tipoPiel,
    String? colorPiel,
    String? texturaPiel,
    String? brilloPiel,
    String? espesorPiel,
    String? turgenciaPiel,
    String? hidratacionPiel,
    String? observaciones1,
    String? sensibilidadPiel,
    String? observaciones2,
    String? orificiosSebaceos,
    String? observaciones3,
    String? parpados,
    String? observaciones4,
    String? pigmentacion,
    String? observaciones5,
    String? arrugas,
    String? observaciones6,
    String? flacidez,
    String? observaciones7,
    String? dermatosis,
    List<String>? tipoAcne,
    String? observaciones8,
    List<String>? lstImagenes,
  }) =>
      PacienteModel(
        uid: uid ?? this.uid,
        data: data ?? this.data,
        usuario: data?['usuario'] ?? this.usuario,
        nombre: data?['nombre'] ?? this.nombre,
        lstImagenes: data?['lstImagenes'] ?? this.lstImagenes,
        edad: data?['edad'] ?? this.edad,
        tipoPiel: data?['tipoPiel'] ?? this.tipoPiel,
        colorPiel: data?['colorPiel'] ?? this.colorPiel,
        texturaPiel: data?['texturaPiel'] ?? this.texturaPiel,
        brilloPiel: data?['brilloPiel'] ?? this.brilloPiel,
        espesorPiel: data?['espesorPiel'] ?? this.espesorPiel,
        turgenciaPiel: data?['turgenciaPiel'] ?? this.turgenciaPiel,
        hidratacionPiel: data?['hidratacionPiel'] ?? this.hidratacionPiel,
        observaciones1: data?['observaciones1'] ?? this.observaciones1,
        sensibilidadPiel: data?['sensibilidadPiel'] ?? this.sensibilidadPiel,
        observaciones2: data?['observaciones2'] ?? this.observaciones2,
        orificiosSebaceos: data?['orificiosSebaceos'] ?? this.orificiosSebaceos,
        observaciones3: data?['observaciones3'] ?? this.observaciones3,
        parpados: data?['parpados'] ?? this.parpados,
        observaciones4: data?['observaciones4'] ?? this.observaciones4,
        pigmentacion: data?['pigmentacion'] ?? this.pigmentacion,
        observaciones5: data?['observaciones5'] ?? this.observaciones5,
        arrugas: data?['arrugas'] ?? this.arrugas,
        observaciones6: data?['observaciones6'] ?? this.observaciones6,
        flacidez: data?['flacidez'] ?? this.flacidez,
        observaciones7: data?['observaciones7'] ?? this.observaciones7,
        dermatosis: data?['dermatosis'] ?? this.dermatosis,
        tipoAcne: data?['tipoAcne'] ?? this.tipoAcne,
        observaciones8: data?['observaciones8'] ?? this.observaciones8,
      );

  factory PacienteModel.fromJson(Map<String, dynamic> json) {
    return PacienteModel(
      uid: (json.containsKey("uid")) ? json["uid"].toString() : '',
      data: json,
      usuario: (json.containsKey("usuario")) ? json["usuario"].toString() : '',
      nombre: (json.containsKey("nombre")) ? json["nombre"].toString() : '',
      lstImagenes: (json.containsKey("lstImagenes")) ? List<String>.from(json['lstImagenes']) : List<String>.from([]),
      edad: (json.containsKey("edad")) ? json["edad"].toString() : '',
      tipoPiel: (json.containsKey("tipoPiel")) ? json["tipoPiel"].toString() : '',
      colorPiel: (json.containsKey("colorPiel")) ? json["colorPiel"].toString() : '',
      texturaPiel: (json.containsKey("texturaPiel")) ? json["texturaPiel"].toString() : '',
      brilloPiel: (json.containsKey("brilloPiel")) ? json["brilloPiel"].toString() : '',
      espesorPiel: (json.containsKey("espesorPiel")) ? json["espesorPiel"].toString() : '',
      turgenciaPiel: (json.containsKey("turgenciaPiel")) ? json["turgenciaPiel"].toString() : '',
      hidratacionPiel: (json.containsKey("hidratacionPiel")) ? json["hidratacionPiel"].toString() : '',
      observaciones1: (json.containsKey("observaciones1")) ? json["observaciones1"].toString() : '',
      sensibilidadPiel: (json.containsKey("sensibilidadPiel")) ? json["sensibilidadPiel"].toString() : '',
      observaciones2: (json.containsKey("observaciones2")) ? json["observaciones2"].toString() : '',
      orificiosSebaceos: (json.containsKey("orificiosSebaceos")) ? json["orificiosSebaceos"].toString() : '',
      observaciones3: (json.containsKey("observaciones3")) ? json["observaciones3"].toString() : '',
      parpados: (json.containsKey("parpados")) ? json["parpados"].toString() : '',
      observaciones4: (json.containsKey("observaciones4")) ? json["observaciones4"].toString() : '',
      pigmentacion: (json.containsKey("pigmentacion")) ? json["pigmentacion"].toString() : '',
      observaciones5: (json.containsKey("observaciones5")) ? json["observaciones5"].toString() : '',
      arrugas: (json.containsKey("arrugas")) ? json["arrugas"].toString() : '',
      observaciones6: (json.containsKey("observaciones6")) ? json["observaciones6"].toString() : '',
      flacidez: (json.containsKey("flacidez")) ? json["flacidez"].toString() : '',
      observaciones7: (json.containsKey("observaciones7")) ? json["observaciones7"].toString() : '',
      dermatosis: (json.containsKey("dermatosis")) ? json["dermatosis"].toString() : '',
      tipoAcne: (json.containsKey("tipoAcne")) ? List<String>.from(json['tipoAcne']) : List<String>.from([]),
      observaciones8: (json.containsKey("observaciones8")) ? json["observaciones8"].toString() : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      "data": data,
      'usuario': usuario,
      'nombre': nombre,
      'edad': edad,
      'tipoPiel': tipoPiel,
      'colorPiel': colorPiel,
      'texturaPiel': texturaPiel,
      'brilloPiel': brilloPiel,
      'espesorPiel': espesorPiel,
      'turgenciaPiel': turgenciaPiel,
      'hidratacionPiel': hidratacionPiel,
      'observaciones1': observaciones1,
      'sensibilidadPiel': sensibilidadPiel,
      'observaciones2': observaciones2,
      'orificiosSebaceos': orificiosSebaceos,
      'observaciones3': observaciones3,
      'parpados': parpados,
      'observaciones4': observaciones4,
      'pigmentacion': pigmentacion,
      'observaciones5': observaciones5,
      'arrugas': arrugas,
      'observaciones6': observaciones6,
      'flacidez': flacidez,
      'observaciones7': observaciones7,
      'dermatosis': dermatosis,
      'observaciones8': observaciones8,
      "tipoAcne": tipoAcne,
      'lstImagenes': lstImagenes,
    };
  }
}
