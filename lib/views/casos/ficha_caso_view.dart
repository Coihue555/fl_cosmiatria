import 'package:fl_cosmiatria/services/firebase_service.dart';
import 'package:fl_cosmiatria/theme/theme.dart';
import 'package:fl_cosmiatria/widgets/dropdown_future_widget.dart';
import 'package:fl_cosmiatria/widgets/image_loader.dart';
import 'package:fl_cosmiatria/widgets/text/text_widget.dart';
import 'package:fl_cosmiatria/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_cosmiatria/models/caso_model.dart';
import 'package:fl_cosmiatria/models/paciente_model.dart';

class FichaCasoView extends StatefulWidget {
  const FichaCasoView({super.key});

  @override
  State<FichaCasoView> createState() => _FichaCasoViewState();
}

class _FichaCasoViewState extends State<FichaCasoView> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController fechaCasoController = TextEditingController();
  TextEditingController observacionesController = TextEditingController();
  List<String> lstImagenes = List<String>.filled(7, '');
  String? selectedPaciente;
  late CasoModel casoModel;
  late Future<List<PacienteModel>> lstPacientes;
  late Map args = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      args = ModalRoute.of(context)!.settings.arguments == null ? {} : ModalRoute.of(context)!.settings.arguments as Map;

      cargarDatos({...args});
    });
    lstPacientes = getPacientes();
  }

  void cargarDatos(Map<dynamic, dynamic> args) async {
    casoModel = CasoModel.fromJson({...args});
    if (args.containsKey('uid')) {
      fechaCasoController.text = casoModel.fechaCaso;
      observacionesController.text = casoModel.observaciones;
      selectedPaciente = casoModel.nombre;
      var tempList = <String>[];
      for (var element in casoModel.lstImagenes) {
        tempList.add(element);
      }
      lstImagenes = tempList;
      nombreController.text = selectedPaciente!;
    }
    if (args.containsKey('desdeFicha')) {
      if (args['desdeFicha'] == 'S') {
        nombreController.text = casoModel.nombre;
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    observacionesController.dispose();
    fechaCasoController.dispose();
    lstImagenes.clear();
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
              texto: args.containsKey('uid') ? 'Editar Caso' : 'Nuevo Caso',
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
                      FutureBuilder(
                          future: getItemDescription(selectedPaciente, lstPacientes),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text("Errorrrr: ${snapshot.error}");
                            } else {
                              return FutureDynamicDropDown(
                                label: 'paciente',
                                lstItems: getPacientes(),
                                valorSeleccionado: snapshot.data,
                                onChanged: (p0) {
                                  selectedPaciente = p0;
                                  nombreController.text = p0;
                                },
                              );
                            }
                          }),
                      TextfieldWidget.fecha(
                          controller: fechaCasoController,
                          labelTitulo: 'Fecha de Atención:',
                          onChanged: (p0) {
                            fechaCasoController.text = p0;
                          },
                          onSubmitted: (value) {
                            fechaCasoController.text = value;
                          }),
                      TextfieldWidget.multilinea(
                        maxLines: 10,
                        labelTitulo: 'Observaciones:',
                        controller: observacionesController,
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
                              imagesOnline: lstImagenes,
                              onImagesSelected: (images) {
                                setState(() {
                                  lstImagenes = images;
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (nombreController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Debe seleccionar un Paciente')));
                          } else if (observacionesController.text.length < 10) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('La observacion debe tener mas de 10 carácteres')));
                          } else {
                            if (args.containsKey('uid')) {
                              await updateCaso(CasoModel(
                                      uid: args['uid'],
                                      usuario: args['usuario'],
                                      nombre: nombreController.text,
                                      fechaCaso: fechaCasoController.text,
                                      observaciones: observacionesController.text,
                                      lstImagenes: lstImagenes))
                                  .then((_) {
                                Navigator.pushNamed(
                                  context,
                                  'lstCasos',
                                );
                              });
                            } else {
                              addCaso(CasoModel(
                                      usuario: user!.email ?? 'no-user',
                                      nombre: nombreController.text,
                                      fechaCaso: fechaCasoController.text,
                                      observaciones: observacionesController.text,
                                      lstImagenes: lstImagenes))
                                  .then((_) {
                                Navigator.pushNamed(
                                  context,
                                  'lstCasos',
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
