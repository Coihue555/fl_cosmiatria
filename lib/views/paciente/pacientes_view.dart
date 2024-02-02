import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_cosmiatria/services/firebase_service.dart';
import 'package:fl_cosmiatria/theme/theme.dart';
import 'package:fl_cosmiatria/views/auth.dart';
import 'package:fl_cosmiatria/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';

class PacientesView extends StatefulWidget {
  const PacientesView({super.key});

  @override
  State<PacientesView> createState() => _PacientesViewState();
}

class _PacientesViewState extends State<PacientesView> {
  late Future<List<dynamic>> lstPacientes;

  TextEditingController searchController = TextEditingController();
  final User? user = Auth().currentUser;

  @override
  void initState() {
    super.initState();
    lstPacientes = getPacientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: lstPacientes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        lstPacientes = filterPacientesByName(value);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Buscar por Nombre u Observacion',
                      labelStyle: TextStyle(color: ThemeModel().colorPrimario),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        var item = snapshot.data?[index];
                        return Dismissible(
                          key: Key(item['uid']),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (direction) async {
                            bool result = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Confirmar'),
                                    content: Text('Esta seguro de eliminar a ${item['nombre']}?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            return Navigator.pop(context, false);
                                          },
                                          child: const Text('Cancelar')),
                                      TextButton(
                                          onPressed: () {
                                            return Navigator.pop(context, true);
                                          },
                                          child: const Text('Confirmar')),
                                    ],
                                  );
                                });
                            return result;
                          },
                          background: Container(
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onDismissed: (direction) async {
                            await deletePaciente(item['uid']);
                            snapshot.data?.removeAt(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            child: InkWell(
                                onTap: () async {
                                  await Navigator.pushNamed(context, 'soloLectura', arguments: {
                                    "usuario": user?.email,
                                    "nombre": item["nombre"],
                                    "edad": item["edad"],
                                    "tipoPiel": item["tipoPiel"],
                                    "colorPiel": item["colorPiel"],
                                    "texturaPiel": item["texturaPiel"],
                                    "brilloPiel": item["brilloPiel"],
                                    "espesorPiel": item["espesorPiel"],
                                    "turgenciaPiel": item["turgenciaPiel"],
                                    "hidratacionPiel": item["hidratacionPiel"],
                                    "observaciones1": item["observaciones1"],
                                    "sensibilidadPiel": item["sensibilidadPiel"],
                                    "observaciones2": item["observaciones2"],
                                    "orificiosSebaceos": item["orificiosSebaceos"],
                                    "observaciones3": item["observaciones3"],
                                    "parpados": item["parpados"],
                                    "observaciones4": item["observaciones4"],
                                    "pigmentacion": item["pigmentacion"],
                                    "observaciones5": item["observaciones5"],
                                    "arrugas": item["arrugas"],
                                    "observaciones6": item["observaciones6"],
                                    "flacidez": item["flacidez"],
                                    "observaciones7": item["observaciones7"],
                                    "dermatosis": item["dermatosis"],
                                    "tipoAcne": item["tipoAcne"],
                                    "observaciones8": item["observaciones8"],
                                    "lstImagenes": item["lstImagenes"],
                                    "uid": item['uid']
                                  });
                                  setState(() {});
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    elevation: 0,
                                    child: ListTile(
                                      tileColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      leading: item['lstImagenes'][0] == ''
                                          ? Image.asset(
                                              'assets/no-image.jpg',
                                              fit: BoxFit.contain,
                                            )
                                          : Image.network(
                                              item['lstImagenes'][0],
                                              fit: BoxFit.contain,
                                            ),
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextWidget.titleLarge(
                                            texto: item['nombre'],
                                            maxlineas: 3,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ],
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (item['tipoPiel'] != null && item['tipoPiel'] != '') Text('Tipo de piel: ${item['tipoPiel'] ?? ''}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        );
                      }),
                ),
              ],
            );
          } else {
            return Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      children: [
                        TextWidget.textLarge(texto: 'Aun no hay datos para mostrar'),
                        Image.asset(
                          'assets/sin_datos.png',
                          fit: BoxFit.contain,
                        ),
                      ],
                    )));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'tag2',
        onPressed: () async {
          await Navigator.pushNamed(context, 'fichaPaciente');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
