import 'package:fl_cosmiatria/views/casos/casos_view.dart';
import 'package:fl_cosmiatria/views/casos/ficha_caso_view.dart';
import 'package:fl_cosmiatria/views/home_view.dart';
import 'package:fl_cosmiatria/views/paciente/ficha_paciente_view.dart';
import 'package:fl_cosmiatria/views/paciente/pacientes_view.dart';
import 'package:fl_cosmiatria/views/paciente/solo_lectura_paciente_view.dart';
import 'package:fl_cosmiatria/views/sesion.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, title: 'Consultorio', initialRoute: '/', routes: {
      '/': (context) => const SesionView(),
      "home": (context) => const Home(),
      'lstPacientes': (context) => const PacientesView(),
      'fichaPaciente': (context) => const FichaPacienteView(),
      'soloLectura': (context) => const SoloLecturaView(),
      'lstCasos': (context) => const CasosView(),
      'fichaCaso': (context) => const FichaCasoView(),
    });
  }
}
