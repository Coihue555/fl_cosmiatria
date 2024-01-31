// ignore_for_file: file_names

import 'package:fl_cosmiatria/views/ficha_paciente_view.dart';
import 'package:fl_cosmiatria/views/home_view.dart';
import 'package:fl_cosmiatria/views/pacientes_view.dart';
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
    });
  }
}
