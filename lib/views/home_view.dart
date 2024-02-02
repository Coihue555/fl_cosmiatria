import 'package:fl_cosmiatria/theme/theme.dart';
import 'package:fl_cosmiatria/views/paciente/pacientes_view.dart';
import 'package:fl_cosmiatria/widgets/drawer_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: ThemeModel().colorPrimario,
        title: const Text(
          'Cosmiatria',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: const MenuLateral(),
      body: const PacientesView(),
      floatingActionButton: FloatingActionButton(
        heroTag: 'tag1',
        onPressed: () async {
          await Navigator.pushNamed(context, 'fichaPaciente');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
