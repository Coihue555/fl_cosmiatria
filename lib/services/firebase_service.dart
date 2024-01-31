import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_cosmiatria/views/auth.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
final User? user = Auth().currentUser;

Future<List> getPacientes() async {
  List pacientes = [];
  CollectionReference collectionReferencePacientes = db.collection('pacientes');
  if (user == null) {
    return pacientes;
  }
  QuerySnapshot queryPacientes = await collectionReferencePacientes.where('usuario', isEqualTo: user!.email).get();
  for (var doc in queryPacientes.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final paciente = {
      "usuario": data["usuario"],
      "nombre": data["nombre"],
      "edad": data["edad"],
      "tipoPiel": data["tipoPiel"],
      "colorPiel": data["colorPiel"],
      "texturaPiel": data["texturaPiel"],
      "brilloPiel": data["brilloPiel"],
      "espesorPiel": data["espesorPiel"],
      "turgenciaPiel": data["turgenciaPiel"],
      "hidratacionPiel": data["hidratacionPiel"],
      "observaciones1": data["observaciones1"],
      "sensibilidadPiel": data["sensibilidadPiel"],
      "observaciones2": data["observaciones2"],
      "orificiosSebaceos": data["orificiosSebaceos"],
      "observaciones3": data["observaciones3"],
      "parpados": data["parpados"],
      "observaciones4": data["observaciones4"],
      "pigmentacion": data["pigmentacion"],
      "observaciones5": data["observaciones5"],
      "arrugas": data["arrugas"],
      "observaciones6": data["observaciones6"],
      "flacidez": data["flacidez"],
      "observaciones7": data["observaciones7"],
      "dermatosis": data["dermatosis"],
      "tipoAcne": data["tipoAcne"],
      "observaciones8": data["observaciones8"],
      "lstImagenes": data["lstImagenes"],
      "uid": doc.id
    };
    pacientes.add(paciente);
  }

  return pacientes;
}

Future<void> addPaciente(
  String usuario,
  String nombre,
  String edad,
  String tipoPiel,
  String colorPiel,
  String texturaPiel,
  String brilloPiel,
  String espesorPiel,
  String turgenciaPiel,
  String hidratacionPiel,
  String observaciones1,
  String sensibilidadPiel,
  String observaciones2,
  String orificiosSebaceos,
  String observaciones3,
  String parpados,
  String observaciones4,
  String pigmentacion,
  String observaciones5,
  String arrugas,
  String observaciones6,
  String flacidez,
  String observaciones7,
  String dermatosis,
  List<String> tipoAcne,
  String observaciones8,
  List<String> lstImagenes,
) async {
  await db.collection('pacientes').add({
    "usuario": usuario,
    "nombre": nombre,
    "edad": edad,
    "tipoPiel": tipoPiel,
    "colorPiel": colorPiel,
    "texturaPiel": texturaPiel,
    "brilloPiel": brilloPiel,
    "espesorPiel": espesorPiel,
    "turgenciaPiel": turgenciaPiel,
    "hidratacionPiel": hidratacionPiel,
    "observaciones1": observaciones1,
    "sensibilidadPiel": sensibilidadPiel,
    "observaciones2": observaciones2,
    "orificiosSebaceos": orificiosSebaceos,
    "observaciones3": observaciones3,
    "parpados": parpados,
    "observaciones4": observaciones4,
    "pigmentacion": pigmentacion,
    "observaciones5": observaciones5,
    "arrugas": arrugas,
    "observaciones6": observaciones6,
    "flacidez": flacidez,
    "observaciones7": observaciones7,
    "dermatosis": dermatosis,
    "tipoAcne": tipoAcne,
    "observaciones8": observaciones8,
    "lstImagenes": lstImagenes
  });
}

Future<void> updatePaciente(
  String uid,
  String usuario,
  String nombre,
  String edad,
  String tipoPiel,
  String colorPiel,
  String texturaPiel,
  String brilloPiel,
  String espesorPiel,
  String turgenciaPiel,
  String hidratacionPiel,
  String observaciones1,
  String sensibilidadPiel,
  String observaciones2,
  String orificiosSebaceos,
  String observaciones3,
  String parpados,
  String observaciones4,
  String pigmentacion,
  String observaciones5,
  String arrugas,
  String observaciones6,
  String flacidez,
  String observaciones7,
  String dermatosis,
  List<String> tipoAcne,
  String observaciones8,
  List<String> lstImagenes,
) async {
  await db.collection('pacientes').doc(uid).set({
    "usuario": usuario,
    "nombre": nombre,
    "edad": edad,
    "tipoPiel": tipoPiel,
    "colorPiel": colorPiel,
    "texturaPiel": texturaPiel,
    "brilloPiel": brilloPiel,
    "espesorPiel": espesorPiel,
    "turgenciaPiel": turgenciaPiel,
    "hidratacionPiel": hidratacionPiel,
    "observaciones1": observaciones1,
    "sensibilidadPiel": sensibilidadPiel,
    "observaciones2": observaciones2,
    "orificiosSebaceos": orificiosSebaceos,
    "observaciones3": observaciones3,
    "parpados": parpados,
    "observaciones4": observaciones4,
    "pigmentacion": pigmentacion,
    "observaciones5": observaciones5,
    "arrugas": arrugas,
    "observaciones6": observaciones6,
    "flacidez": flacidez,
    "observaciones7": observaciones7,
    "dermatosis": dermatosis,
    "tipoAcne": tipoAcne,
    "observaciones8": observaciones8,
    "lstImagenes": lstImagenes
  });
}

Future<void> deletePaciente(String uid) async {
  await db.collection('pacientes').doc(uid).delete();
}

Future<List<dynamic>> filterPacientesByName(String palabra) async {
  List<dynamic> allPacientes = await getPacientes();
  if (palabra.isEmpty) {
    return allPacientes;
  }
  return allPacientes.where((paciente) => paciente['nombre'].toLowerCase().contains(palabra.toLowerCase())).toList();
}

Future<List> findMatchingCases(String horseName) async {
  List<dynamic> lstPacientes = await getPacientes();
  List<dynamic> lstCasos = await getCasos();

  if (horseName.isEmpty) {
    return lstCasos;
  } else {
    List<String> matchingPacienteUids = [];
    for (var horse in lstPacientes) {
      if (horse['name'].toLowerCase().contains(horseName.toLowerCase())) {
        matchingPacienteUids.add(horse['uid']);
      }
    }

    List<Map<String, dynamic>> matchingCases = [];
    for (var caso in lstCasos) {
      if (matchingPacienteUids.contains(caso['caballo'])) {
        matchingCases.add(caso);
      }
    }
    return matchingCases;
  }
}

///Recibe un uid y retorna el valor de la clave 'label'
Future<String>? getItemDescription(String label, String? itemUid, Future<List<dynamic>> lstItem) async {
  if (itemUid == null) return '';
  var item = await lstItem.then((items) => items.firstWhere((item) => item['uid'] == itemUid, orElse: () => {}));
  return item[label] ?? 'Seleccione una opcion';
}

Future<String>? getItemName(String label, String? itemUid, Future<List<dynamic>> lstItem) async {
  if (itemUid == null) return '';
  var item = await lstItem.then((items) => items.firstWhere((item) => item['uid'] == itemUid, orElse: () => {}));
  return item[label] ?? 'Seleccione una opcion';
}

Future<List> getCasos() async {
  List casos = [];
  CollectionReference collectionReferenceCasos = db.collection('casos');

  QuerySnapshot queryCasos = await collectionReferenceCasos.get();
  for (var doc in queryCasos.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final caso = {
      "uid": doc.id,
      "caballo": data["caballo"],
      "fechaCaso": data["fechaCaso"],
      "observaciones": data["observaciones"],
      "lstImagenes": data["lstImagenes"],
    };
    casos.add(caso);
  }

  return casos;
}
