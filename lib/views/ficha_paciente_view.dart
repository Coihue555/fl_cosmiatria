import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_cosmiatria/services/firebase_service.dart';
import 'package:fl_cosmiatria/theme/theme.dart';
import 'package:fl_cosmiatria/views/auth.dart';
import 'package:fl_cosmiatria/widgets/dropdown_widget.dart';
import 'package:fl_cosmiatria/widgets/image_loader.dart';
import 'package:fl_cosmiatria/widgets/text/text_widget.dart';
import 'package:fl_cosmiatria/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FichaPacienteView extends StatefulWidget {
  const FichaPacienteView({super.key});

  @override
  State<FichaPacienteView> createState() => _FichaPacienteViewState();
}

class _FichaPacienteViewState extends State<FichaPacienteView> {
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
      args = (ModalRoute.of(context)!.settings.arguments as Map);
      cargarDatos({...args});
    });
    lstPacientes = getPacientes();
  }

  void cargarDatos(Map<dynamic, dynamic> args) async {
    nombreController.text = args.containsKey('uid') ? args['nombre'] : '';
    edadController.text = args.containsKey('uid') ? args['edad'] : '';
    tipoPielController.text = args.containsKey('uid') ? args['tipoPiel'] : '';
    colorPielController.text = args.containsKey('uid') ? args['colorPiel'] : '';
    texturaPielController.text = args.containsKey('uid') ? args['texturaPiel'] : '';
    brilloPielController.text = args.containsKey('uid') ? args['brilloPiel'] : '';
    espesorPielController.text = args.containsKey('uid') ? args['espesorPiel'] : '';
    turgenciaPielController.text = args.containsKey('uid') ? args['turgenciaPiel'] : '';
    hidratacionPielController.text = args.containsKey('uid') ? args['hidratacionPiel'] : '';
    obser1Controller.text = args.containsKey('uid') ? args['observaciones1'] : '';
    sensibilidadController.text = args.containsKey('uid') ? args['sensibilidadPiel'] : '';
    obser2Controller.text = args.containsKey('uid') ? args['observaciones2'] : '';
    orificiosSebaceosController.text = args.containsKey('uid') ? args['orificiosSebaceos'] : '';
    obser3Controller.text = args.containsKey('uid') ? args['observaciones3'] : '';
    parpadosController.text = args.containsKey('uid') ? args['parpados'] : '';
    obser4Controller.text = args.containsKey('uid') ? args['observaciones4'] : '';
    pigmentacionController.text = args.containsKey('uid') ? args['pigmentacion'] : '';
    obser5Controller.text = args.containsKey('uid') ? args['observaciones5'] : '';
    arrugasController.text = args.containsKey('uid') ? args['arrugas'] : '';
    obser6Controller.text = args.containsKey('uid') ? args['observaciones6'] : '';
    flacidezController.text = args.containsKey('uid') ? args['flacidez'] : '';
    obser7Controller.text = args.containsKey('uid') ? args['observaciones7'] : '';
    dermatosisController.text = args.containsKey('uid') ? args['dermatosis'] : '';
    obser8Controller.text = args.containsKey('uid') ? args['observaciones8'] : '';
    if (args.containsKey('uid')) {
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
              texto: args.containsKey('uid') ? 'Editar Paciente' : 'Nueva Paciente',
              colorTextoDark: Colors.white,
              colorTextoLight: Colors.white,
            )),
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
                      TextfieldWidget.texto(
                        labelTitulo: 'Nombre:',
                        controller: nombreController,
                      ),
                      TextfieldWidget.texto(
                        labelTitulo: 'Edad:',
                        controller: edadController,
                      ),
                      DynamicDropDown(
                        label: 'Tipo de Piel:',
                        lstItems: const [
                          "Grasa",
                          "Alipida",
                          "Mixta",
                          "Eudermica",
                        ],
                        valorSeleccionado: tipoPielController.text,
                        onChanged: (p0) {
                          tipoPielController.text = p0;
                        },
                      ),
                      DynamicDropDown(
                        label: 'Color:',
                        lstItems: const [
                          "Normal",
                          "Palida/Opaca",
                          "Rojiza/Sensible",
                        ],
                        valorSeleccionado: colorPielController.text,
                        onChanged: (p0) {
                          colorPielController.text = p0;
                        },
                      ),
                      DynamicDropDown(
                        label: 'Textura:',
                        lstItems: const [
                          "Lisa",
                          "Rugosa",
                        ],
                        valorSeleccionado: texturaPielController.text,
                        onChanged: (p0) {
                          texturaPielController.text = p0;
                        },
                      ),
                      DynamicDropDown(
                        label: 'Brillo:',
                        lstItems: const [
                          "Luminosa",
                          "Untuosa",
                          "Opaca",
                        ],
                        valorSeleccionado: brilloPielController.text,
                        onChanged: (p0) {
                          brilloPielController.text = p0;
                        },
                      ),
                      DynamicDropDown(
                        label: 'Espesor:',
                        lstItems: const [
                          "Fina",
                          "Normal",
                          "Gruesa",
                        ],
                        valorSeleccionado: espesorPielController.text,
                        onChanged: (p0) {
                          espesorPielController.text = p0;
                        },
                      ),
                      DynamicDropDown(
                        label: 'Turgencia:',
                        lstItems: const [
                          "Regular",
                          "Buena",
                          "Muy Buena",
                        ],
                        valorSeleccionado: turgenciaPielController.text,
                        onChanged: (p0) {
                          turgenciaPielController.text = p0;
                        },
                      ),
                      DynamicDropDown(
                        label: 'Hidratación:',
                        lstItems: const [
                          "Normal",
                          "Deshidratada",
                          "Sobredeshidratada",
                        ],
                        valorSeleccionado: hidratacionPielController.text,
                        onChanged: (p0) {
                          hidratacionPielController.text = p0;
                        },
                      ),
                      TextfieldWidget.texto(
                        labelTitulo: 'Observacion 1:',
                        controller: obser1Controller,
                      ),
                      DynamicDropDown(
                        label: 'Sensibilidad:',
                        lstItems: const ["Ardor", "Calor", "Tirantez"],
                        valorSeleccionado: sensibilidadController.text,
                        onChanged: (p0) {
                          sensibilidadController.text = p0;
                        },
                      ),
                      TextfieldWidget.texto(
                        labelTitulo: 'Observacion 2:',
                        controller: obser2Controller,
                      ),
                      DynamicDropDown(
                        label: 'Orificios pilo sebáceos:',
                        lstItems: const [
                          "Imperceptibles",
                          "Dilatados",
                        ],
                        valorSeleccionado: orificiosSebaceosController.text,
                        onChanged: (p0) {
                          orificiosSebaceosController.text = p0;
                        },
                      ),
                      TextfieldWidget.texto(
                        labelTitulo: 'Observacion 3:',
                        controller: obser3Controller,
                      ),
                      DynamicDropDown(
                        label: 'Párpados:',
                        lstItems: const [
                          "Bolsas",
                          "Ojeras",
                        ],
                        valorSeleccionado: parpadosController.text,
                        onChanged: (p0) {
                          parpadosController.text = p0;
                        },
                      ),
                      TextfieldWidget.texto(
                        labelTitulo: 'Observacion 4:',
                        controller: obser4Controller,
                      ),
                      DynamicDropDown(
                        label: 'Pigmentación:',
                        lstItems: const [
                          "Hiperpigmentación",
                          "Hipopigmentación",
                        ],
                        valorSeleccionado: pigmentacionController.text,
                        onChanged: (p0) {
                          pigmentacionController.text = p0;
                        },
                      ),
                      TextfieldWidget.texto(
                        labelTitulo: 'Observacion 5:',
                        controller: obser5Controller,
                      ),
                      DynamicDropDown(
                        label: 'Arrugas:',
                        lstItems: const [
                          "Frontales",
                          "Grabelares",
                          "Periorbiculares",
                          "Nasogenianas",
                          "Peribucales",
                          "Cuello",
                        ],
                        valorSeleccionado: arrugasController.text,
                        onChanged: (p0) {
                          arrugasController.text = p0;
                        },
                      ),
                      TextfieldWidget.texto(
                        labelTitulo: 'Observacion 6:',
                        controller: obser6Controller,
                      ),
                      DynamicDropDown(
                        label: 'Flacidez:',
                        lstItems: const [
                          "Párpados",
                          "Mejillas",
                          "Cuello",
                        ],
                        valorSeleccionado: flacidezController.text,
                        onChanged: (p0) {
                          flacidezController.text = p0;
                        },
                      ),
                      TextfieldWidget.texto(
                        labelTitulo: 'Observacion 7:',
                        controller: obser7Controller,
                      ),
                      DynamicDropDown(
                        label: 'Dermatosis:',
                        lstItems: const [
                          "Acne",
                          "Rosacea",
                        ],
                        valorSeleccionado: dermatosisController.text,
                        onChanged: (p0) {
                          dermatosisController.text = p0;
                        },
                      ),
                      if (dermatosisController.text == 'Acne')
                        // DynamicDropDown(
                        //   label: 'Tipos de acne:',
                        //   lstItems: const ["Puntos negros", "Pápulas", "Quistes", "Puntos blancos", "Pústulas", "Nódulos"],
                        //   valorSeleccionado: lstTipoAcne,
                        //   onChanged: (p0) {
                        //     dermatosisController.text = p0;
                        //   },
                        // ),
                        TextfieldWidget.texto(
                          labelTitulo: 'Observacion 8:',
                          controller: obser8Controller,
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget.textLarge(
                            texto: 'Subir imagenes:',
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
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (nombreController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nombre no pueden estar vacio')));
                          } else {
                            if (args.containsKey('uid')) {
                              await updatePaciente(
                                args['uid'],
                                args['usuario'],
                                nombreController.text,
                                edadController.text,
                                tipoPielController.text,
                                colorPielController.text,
                                texturaPielController.text,
                                brilloPielController.text,
                                espesorPielController.text,
                                turgenciaPielController.text,
                                hidratacionPielController.text,
                                obser1Controller.text,
                                sensibilidadController.text,
                                obser2Controller.text,
                                orificiosSebaceosController.text,
                                obser3Controller.text,
                                parpadosController.text,
                                obser4Controller.text,
                                pigmentacionController.text,
                                obser5Controller.text,
                                arrugasController.text,
                                obser6Controller.text,
                                flacidezController.text,
                                obser7Controller.text,
                                dermatosisController.text,
                                lstTipoAcne,
                                obser8Controller.text,
                                lstImagenes,
                              ).then((_) {
                                Navigator.pushNamed(
                                  context,
                                  'home',
                                );
                              });
                            } else {
                              addPaciente(
                                user!.email ?? 'no-user',
                                nombreController.text,
                                edadController.text,
                                tipoPielController.text,
                                colorPielController.text,
                                texturaPielController.text,
                                brilloPielController.text,
                                espesorPielController.text,
                                turgenciaPielController.text,
                                hidratacionPielController.text,
                                obser1Controller.text,
                                sensibilidadController.text,
                                obser2Controller.text,
                                orificiosSebaceosController.text,
                                obser3Controller.text,
                                parpadosController.text,
                                obser4Controller.text,
                                pigmentacionController.text,
                                obser5Controller.text,
                                arrugasController.text,
                                obser6Controller.text,
                                flacidezController.text,
                                obser7Controller.text,
                                dermatosisController.text,
                                lstTipoAcne,
                                obser8Controller.text,
                                lstImagenes,
                              ).then((_) {
                                Navigator.pushNamed(
                                  context,
                                  'home',
                                );
                              });
                            }
                          }
                        },
                        child: const Text('Guardar')),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
