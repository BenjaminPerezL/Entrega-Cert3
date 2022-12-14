import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_movil/pages/admin/admin_home.dart';
import 'package:proyecto_movil/pages/cliente/cliente_home.dart';
import 'package:proyecto_movil/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import '../widgets/boton_iniciar.dart';
//import '../widgets/form_email.dart';
//import '../widgets/form_passw.dart';
import '../widgets/form_email.dart';
import '../widgets/form_passw.dart';
import '../widgets/imagen_fondo.dart';
import 'package:proyecto_movil/auth_google.dart';

import '../constantes.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String error = "";
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ImagenFondo(
          imagen: 'assets/images/descarga.png',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.black.withOpacity(0.6),
            ),
            child: Column(
              children: [
                Flexible(
                  child: Center(
                      child: Image.asset(
                    'assets/images/alce.png',
                    height: 150,
                    width: 250,
                  )),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 28.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Inicio de Sesi??n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                      ),
                    ),

                    //---------------INPUT EMAIL-------------------
                    FormularioEmail(text: 'Email', emailCtrl: emailCtrl),

                    //----------INPUT PASSWORD---------------
                    FormularioPass(passwordCtrl: passwordCtrl),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red),
                    ),

                    //--------BOTON LOGIN----------
                    Container(
                      height: size.height * 0.08,
                      width: size.width * 0.8,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Color(kBoton)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                          ),
                        ),
                        // onPressed: () {
                        //   print(emailCtrl.text.trim().toString());
                        //   print("hola");
                        // },
                        onPressed: () => login(),
                        child: Text(
                          'Iniciar Sesion',
                          style:
                              kBodyText.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '-Inicia Sesion Con-',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //---GOOGLE LOGIN
                    ElevatedButton(
                      onPressed: () {
                        //AuthService().handleAuthState();
                        //AuthService().signOutGoogle();
                        AuthService().signInWithGoogle();
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent),
                      child: Image.asset(
                        'assets/images/google.png',
                        height: 40,
                        width: 40,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent),
                      child: Image.asset(
                        'assets/images/facebook.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent),
                      child: Image.asset(
                        'assets/images/twitter.png',
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void login() async {
    try {
      //Intentar login

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text.trim(),
      );

      //CREDENCIALES OK
      //guardar email

      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('userEmail', userCredential.user!.email.toString());

      //redirigir al home

      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => Cliente_Home());

      if (userCredential.user!.email.toString() == 'admin@gmail.com') {
        route = MaterialPageRoute(
          builder: (context) => Admin_Home(),
        );
      }
      ;

      Navigator.pushReplacement(context, route);
    } on FirebaseAuthException catch (ex) {
      //CASO DE LOGIN NO VALIDO
      switch (ex.code) {
        case 'unknown':
          error = 'Correo no Ingresado';
          break;
        case 'invalid-email':
          error = 'Correo invalido';
          break;
        case 'user-not-found':
          error = 'Usuario no existe';
          break;
        case 'wrong-password':
          error = 'Contrase??a incorrecta';
          break;
        case 'user-disabled':
          error = 'Cuenta desactivada';
          break;
        default:
          //print(ex.code);
          error = ex.message.toString();
          break;
      }
      setState(() {});
    }
  }
}
