import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_cosmiatria/views/auth.dart';
import 'package:fl_cosmiatria/widgets/text/text_widget.dart';
import 'package:fl_cosmiatria/widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isObscured = false;
  String? errorMessage = "";
  bool isLogin = true;
  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 217, 226),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(height: 300, child: Image.asset('assets/images/cosmetic.png')),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 120,
                      ),
                      SizedBox(height: 60, child: Image.asset('assets/images/loto.png')),
                      TextWidget.headLineLarge(
                        texto: 'DANIELA FERREYRA',
                        colorTextoDark: Colors.brown,
                        colorTextoLight: Colors.brown,
                      ),
                      TextWidget.headLineSmall(
                        texto: 'cosmiatra',
                        colorTextoDark: Colors.brown,
                        colorTextoLight: Colors.brown,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget.titleLarge(
                            texto: 'Email',
                            colorTextoDark: Colors.brown,
                            colorTextoLight: Colors.brown,
                          ),
                          TextfieldWidget.email(
                            labelTitulo: '',
                            controller: emailController,
                          ),
                          TextWidget.titleLarge(
                            texto: 'Password',
                            colorTextoDark: Colors.brown,
                            colorTextoLight: Colors.brown,
                          ),
                          TextfieldWidget.contrasena(
                            labelTitulo: '',
                            controller: passwordController,
                            obscureText: isObscured,
                            ontap: () {
                              isObscured = !isObscured;
                              setState(() {});
                            },
                          ),
                          TextWidget.textSmall(
                            texto: errorMessage ?? '',
                            maxlineas: 3,
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            isLogin ? signInWithEmailAndPassword() : createUserWithEmailAndPassword();
                          },
                          child: TextWidget.titleLarge(texto: isLogin ? 'Ingresar' : 'Crear Usuario')),
                      TextWidget.textLarge(texto: 'o'),
                      ElevatedButton(
                          onPressed: () async {
                            isLogin = !isLogin;
                            setState(() {});
                          },
                          child: TextWidget.titleLarge(texto: isLogin ? 'Registrarse' : 'Iniciar Sesión'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
