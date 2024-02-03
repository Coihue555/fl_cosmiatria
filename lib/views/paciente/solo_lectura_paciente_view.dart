import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_cosmiatria/services/firebase_service.dart';
import 'package:fl_cosmiatria/theme/theme.dart';
import 'package:fl_cosmiatria/views/auth.dart';
import 'package:fl_cosmiatria/widgets/image_loader.dart';
import 'package:fl_cosmiatria/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SoloLecturaView extends StatefulWidget {
  const SoloLecturaView({super.key});

  @override
  State<SoloLecturaView> createState() => _SoloLecturaViewState();
}

class _SoloLecturaViewState extends State<SoloLecturaView> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController edadController = TextEditingController();
  TextEditingController tipoPielController = TextEditingController();
  TextEditingController colorPielController = TextEditingController();
  TextEditingController texturaPielController = TextEditingController();
  TextEditingController brilloPielController = TextEditingController();
  TextEditingController espesorPielController = TextEditingController();
  TextEditingController turgenciaPielController = TextEditingController();
  TextEditingController hidratacionPielController = TextEditingController();
  TextEditingController obser1Controller = TextEditingController();
  TextEditingController sensibilidadController = TextEditingController();
  TextEditingController obser2Controller = TextEditingController();
  TextEditingController orificiosSebaceosController = TextEditingController();
  TextEditingController obser3Controller = TextEditingController();
  TextEditingController parpadosController = TextEditingController();
  TextEditingController obser4Controller = TextEditingController();
  TextEditingController pigmentacionController = TextEditingController();
  TextEditingController obser5Controller = TextEditingController();
  TextEditingController arrugasController = TextEditingController();
  TextEditingController obser6Controller = TextEditingController();
  TextEditingController flacidezController = TextEditingController();
  TextEditingController obser7Controller = TextEditingController();
  TextEditingController dermatosisController = TextEditingController();
  List<String> lstTipoAcne = [];
  TextEditingController obser8Controller = TextEditingController();
  List<String> lstImagenes = List<String>.filled(7, '');
  final User? user = Auth().currentUser;
  late Future<List<dynamic>> lstPacientes;
  late Map args = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var tempMap = ModalRoute.of(context)!.settings.arguments == null ? {} : ModalRoute.of(context)!.settings.arguments as Map;
      args = {...tempMap};
      cargarDatos({...args});
    });
    lstPacientes = getPacientes();
  }

  void cargarDatos(Map<dynamic, dynamic> args) async {
    if (args.containsKey('uid')) {
      nombreController.text = args['nombre'] ?? '';
      edadController.text = args['edad'] ?? '';
      tipoPielController.text = args['tipoPiel'] ?? '';
      colorPielController.text = args['colorPiel'] ?? '';
      texturaPielController.text = args['texturaPiel'] ?? '';
      brilloPielController.text = args['brilloPiel'] ?? '';
      espesorPielController.text = args['espesorPiel'] ?? '';
      turgenciaPielController.text = args['turgenciaPiel'] ?? '';
      hidratacionPielController.text = args['hidratacionPiel'] ?? '';
      obser1Controller.text = args['observaciones1'] ?? '';
      sensibilidadController.text = args['sensibilidadPiel'] ?? '';
      obser2Controller.text = args['observaciones2'] ?? '';
      orificiosSebaceosController.text = args['orificiosSebaceos'] ?? '';
      obser3Controller.text = args['observaciones3'] ?? '';
      parpadosController.text = args['parpados'] ?? '';
      obser4Controller.text = args['observaciones4'] ?? '';
      pigmentacionController.text = args['pigmentacion'] ?? '';
      obser5Controller.text = args['observaciones5'] ?? '';
      arrugasController.text = args['arrugas'] ?? '';
      obser6Controller.text = args['observaciones6'] ?? '';
      flacidezController.text = args['flacidez'] ?? '';
      obser7Controller.text = args['observaciones7'] ?? '';
      dermatosisController.text = args['dermatosis'] ?? '';
      obser8Controller.text = args['observaciones8'] ?? '';
    }
    if (args.containsKey('uid') && args['dermatosis'] == 'Acne') {
      var tempList = <String>[];
      for (var element in args['tipoAcne']) {
        tempList.add(element);
      }
      lstTipoAcne = tempList;
    }
    if (args.containsKey('uid')) {
      var tempList = <String>[];
      for (var element in args['lstImagenes']) {
        tempList.add(element);
      }
      lstImagenes = tempList;
    }
    setState(() {});
  }

  Map<String, bool> options = {
    "Puntos negros": false,
    "Pápulas": false,
    "Quistes": false,
    "Puntos blancos": false,
    "Pústulas": false,
    "Nódulos": false,
  };

  List<String> getSelectedOptions() {
    return options.entries.where((entry) => entry.value).map((entry) => entry.key).toList();
  }

  @override
  void dispose() {
    nombreController.dispose();
    edadController.dispose();
    tipoPielController.dispose();
    colorPielController.dispose();
    texturaPielController.dispose();
    brilloPielController.dispose();
    espesorPielController.dispose();
    turgenciaPielController.dispose();
    hidratacionPielController.dispose();
    obser1Controller.dispose();
    sensibilidadController.dispose();
    obser2Controller.dispose();
    orificiosSebaceosController.dispose();
    obser3Controller.dispose();
    parpadosController.dispose();
    obser4Controller.dispose();
    pigmentacionController.dispose();
    obser5Controller.dispose();
    arrugasController.dispose();
    obser6Controller.dispose();
    flacidezController.dispose();
    obser7Controller.dispose();
    dermatosisController.dispose();
    obser8Controller.dispose();
    lstImagenes.clear();
    lstTipoAcne.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: ThemeModel().colorPrimario,
          title: TextWidget.titleLarge(
            texto: 'Datos Paciente',
            colorTextoDark: Colors.white,
            colorTextoLight: Colors.white,
          ),
          actions: [
            InkWell(
                onTap: () async {
                  await Navigator.pushNamed(context, 'fichaPaciente', arguments: {
                    "usuario": user?.email,
                    "nombre": args["nombre"],
                    "edad": args["edad"],
                    "tipoPiel": args["tipoPiel"],
                    "colorPiel": args["colorPiel"],
                    "texturaPiel": args["texturaPiel"],
                    "brilloPiel": args["brilloPiel"],
                    "espesorPiel": args["espesorPiel"],
                    "turgenciaPiel": args["turgenciaPiel"],
                    "hidratacionPiel": args["hidratacionPiel"],
                    "observaciones1": args["observaciones1"],
                    "sensibilidadPiel": args["sensibilidadPiel"],
                    "observaciones2": args["observaciones2"],
                    "orificiosSebaceos": args["orificiosSebaceos"],
                    "observaciones3": args["observaciones3"],
                    "parpados": args["parpados"],
                    "observaciones4": args["observaciones4"],
                    "pigmentacion": args["pigmentacion"],
                    "observaciones5": args["observaciones5"],
                    "arrugas": args["arrugas"],
                    "observaciones6": args["observaciones6"],
                    "flacidez": args["flacidez"],
                    "observaciones7": args["observaciones7"],
                    "dermatosis": args["dermatosis"],
                    "tipoAcne": args["tipoAcne"],
                    "observaciones8": args["observaciones8"],
                    "lstImagenes": args["lstImagenes"],
                    "uid": args['uid']
                  });
                  setState(() {});
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.edit_document),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextWidget.textLarge(
                            colorTextoDark: ThemeModel().colorPrimario,
                            colorTextoLight: ThemeModel().colorPrimario,
                            texto: 'Nombre: ',
                          ),
                          TextWidget.textLarge(texto: nombreController.text)
                        ],
                      ),
                      Row(
                        children: [
                          TextWidget.textLarge(
                            colorTextoDark: ThemeModel().colorPrimario,
                            colorTextoLight: ThemeModel().colorPrimario,
                            texto: 'Edad: ',
                          ),
                          TextWidget.textLarge(texto: edadController.text)
                        ],
                      ),
                      Row(
                        children: [
                          TextWidget.textLarge(
                            colorTextoDark: ThemeModel().colorPrimario,
                            colorTextoLight: ThemeModel().colorPrimario,
                            texto: 'Tipo de Piel: ',
                          ),
                          TextWidget.textLarge(texto: tipoPielController.text)
                        ],
                      ),
                      if (colorPielController.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Color: ',
                            ),
                            TextWidget.textLarge(texto: colorPielController.text)
                          ],
                        ),
                      if (texturaPielController.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Textura: ',
                            ),
                            TextWidget.textLarge(texto: texturaPielController.text)
                          ],
                        ),
                      if (brilloPielController.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Brillo: ',
                            ),
                            TextWidget.textLarge(texto: brilloPielController.text)
                          ],
                        ),
                      if (espesorPielController.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Espesor: ',
                            ),
                            TextWidget.textLarge(texto: espesorPielController.text)
                          ],
                        ),
                      if (turgenciaPielController.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Turgencia: ',
                            ),
                            TextWidget.textLarge(texto: turgenciaPielController.text)
                          ],
                        ),
                      if (hidratacionPielController.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Hidratación: ',
                            ),
                            TextWidget.textLarge(texto: hidratacionPielController.text)
                          ],
                        ),
                      if (obser1Controller.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Observacion 1: ',
                            ),
                            TextWidget.textLarge(texto: obser1Controller.text)
                          ],
                        ),
                      if (sensibilidadController.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Sensibilidad: ',
                            ),
                            TextWidget.textLarge(texto: sensibilidadController.text)
                          ],
                        ),
                      if (obser2Controller.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Observacion 2: ',
                            ),
                            TextWidget.textLarge(texto: obser2Controller.text)
                          ],
                        ),
                      if (orificiosSebaceosController.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Orificios pilo sebáceos: ',
                            ),
                            TextWidget.textLarge(texto: orificiosSebaceosController.text)
                          ],
                        ),
                      if (obser3Controller.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Observacion 3: ',
                            ),
                            TextWidget.textLarge(texto: obser3Controller.text)
                          ],
                        ),
                      if (parpadosController.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Párpados: ',
                            ),
                            TextWidget.textLarge(texto: parpadosController.text)
                          ],
                        ),
                      if (obser4Controller.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Observacion 4: ',
                            ),
                            TextWidget.textLarge(texto: obser4Controller.text)
                          ],
                        ),
                      if (pigmentacionController.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Pigmentación: ',
                            ),
                            TextWidget.textLarge(texto: pigmentacionController.text)
                          ],
                        ),
                      if (obser5Controller.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Observacion 5: ',
                            ),
                            TextWidget.textLarge(texto: obser5Controller.text)
                          ],
                        ),
                      if (arrugasController.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Arrugas: ',
                            ),
                            TextWidget.textLarge(texto: arrugasController.text)
                          ],
                        ),
                      if (obser6Controller.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Observacion 6: ',
                            ),
                            TextWidget.textLarge(texto: obser6Controller.text)
                          ],
                        ),
                      if (flacidezController.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Flacidez: ',
                            ),
                            TextWidget.textLarge(texto: flacidezController.text)
                          ],
                        ),
                      if (obser7Controller.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Observacion 7: ',
                            ),
                            TextWidget.textLarge(texto: obser7Controller.text)
                          ],
                        ),
                      if (dermatosisController.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Dermatosis: ',
                            ),
                            TextWidget.textLarge(texto: dermatosisController.text)
                          ],
                        ),
                      if (dermatosisController.text == 'Acne' && lstTipoAcne.isNotEmpty)
                        Wrap(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Tipos de Acne: ',
                            ),
                            TextWidget.textLarge(maxlineas: 3, texto: lstTipoAcne.join(', '))
                          ],
                        ),
                      if (obser7Controller.text.isNotEmpty)
                        Row(
                          children: [
                            TextWidget.textLarge(
                              colorTextoDark: ThemeModel().colorPrimario,
                              colorTextoLight: ThemeModel().colorPrimario,
                              texto: 'Observacion 7: ',
                            ),
                            TextWidget.textLarge(texto: obser7Controller.text)
                          ],
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget.textLarge(
                            texto: 'Imagenes:',
                            colorTextoDark: ThemeModel().colorPrimario,
                            colorTextoLight: ThemeModel().colorPrimario,
                          ),
                          const SizedBox(height: 10),
                          ImageUploadWidget(
                              prefixDownload: nombreController.text,
                              imagesOnline: lstImagenes,
                              onImagesSelected: (images) {
                                setState(() {
                                  lstImagenes = images;
                                });
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Historial Clínico:',
                            style: TextStyle(fontSize: 17, color: ThemeModel().colorPrimario),
                          ),
                          InkWell(
                            onTap: () async {
                              await Navigator.pushNamed(context, 'fichaCaso', arguments: {"caballo": args['uid'], "desdeFicha": 'S'});
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white, border: Border.all(color: Colors.grey), borderRadius: const BorderRadius.all(Radius.circular(5))),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Text(
                                'Nuevo Caso',
                                style: TextStyle(fontSize: 15, color: ThemeModel().colorPrimario),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: getCasos(),
                          builder: (context, snapshotCasos) {
                            if (snapshotCasos.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshotCasos.hasError) {
                              return Text("Errorrrr: ${snapshotCasos.error}");
                            } else {
                              var lstNueva = snapshotCasos.data?.where((caso) => caso.nombre == args['uid']).toList();
                              return SizedBox(
                                height: lstNueva!.isNotEmpty ? lstNueva.length * 26 : 10,
                                child: ListView.builder(
                                    itemCount: lstNueva.length,
                                    itemBuilder: (context, index) {
                                      var item = lstNueva[index];
                                      return InkWell(
                                          onTap: () async {
                                            await Navigator.pushNamed(context, 'fichaCaso', arguments: {
                                              "uid": item.uid,
                                              "nombre": item.nombre,
                                              "fechaCaso": item.fechaCaso,
                                              "observaciones": item.observaciones,
                                              "lstImagenes": item.lstImagenes,
                                            });
                                            setState(() {});
                                          },
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  TextWidget.textLarge(
                                                      maxlineas: 1,
                                                      texto:
                                                          item.observaciones.toString().length < 36 ? item.observaciones : item.observaciones.substring(0, 35)),
                                                  TextWidget.textLarge(texto: item.fechaCaso),
                                                ],
                                              ),
                                              const Divider(
                                                thickness: 0.5,
                                                height: 2,
                                              )
                                            ],
                                          ));
                                    }),
                              );
                            }
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
