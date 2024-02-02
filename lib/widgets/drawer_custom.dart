import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_cosmiatria/theme/theme.dart';
import 'package:fl_cosmiatria/views/auth.dart';
import 'package:fl_cosmiatria/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;
    return Drawer(
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          ListView(
            children: [
              Container(color: const Color.fromARGB(255, 255, 239, 231), height: 200, child: Image.asset('assets/images/icon-710x599-android.jpg')),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget.headLineMedium(texto: 'Cosmiatría'),
                    TextWidget.textSmall(texto: 'v0.1'),
                  ],
                ),
              ),
              const Divider(
                height: 4,
                thickness: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextWidget.textLarge(maxlineas: 3, texto: 'Usuario: ${user?.email}'),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: TextWidget.headLineSmall(texto: 'Inicio'),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'home',
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: TextWidget.headLineSmall(texto: 'Casos'),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'lstCasos',
                  );
                },
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: InkWell(
              onTap: () {
                Auth().signOut();
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ThemeModel().colorPrimario,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    TextWidget.headLineSmall(
                      texto: 'Cerrar Sesión',
                      colorTextoDark: Colors.white,
                      colorTextoLight: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
