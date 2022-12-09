import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_movil/pages/cliente/cliente_detalle_entrada.dart';
import 'package:proyecto_movil/pages/cliente/cliente_listar_entrada.dart';
import 'package:proyecto_movil/pages/cliente/cliente_noticias.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth_google.dart';
import '../../constantes.dart';
import '../../widgets/events.dart';
import '../event_page.dart';
import '../login.dart';
import 'cliente_listar_eventos.dart';

class Cliente_Home extends StatefulWidget {
  const Cliente_Home({super.key});

  @override
  State<Cliente_Home> createState() => _Cliente_HomeState();
}

class _Cliente_HomeState extends State<Cliente_Home> {
  int tabindex = 1;
  final screens = [
    EntradasListarPage(),
    ClienteNoticias(),
    ClienteEventosListarPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(kAppBar),
          title: Text(
            'Cliente Page',
            style: kAppBarText,
          ),
          actions: [
            Row(
              children: [
                //comente el mail para entrar sin logear
                Text(FirebaseAuth.instance.currentUser!.email!),
                IconButton(
                    onPressed: () {
                      AuthService().signOut(context);
                      //logout(context);
                    },
                    icon: Icon(MdiIcons.exitRun)),
              ],
            )
          ],
        ),
        backgroundColor: Color(kBackground2),
        body: screens[tabindex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(kNav),
          currentIndex: tabindex,
          onTap: (index) => setState(
            () => tabindex = index,
          ),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          showUnselectedLabels: false,
          iconSize: 30,
          selectedFontSize: 16,
          items: [
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.ticketAccount),
              label: 'Mis tickets',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.newspaperVariantMultiple),
              label: 'Noticias',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.cart),
              label: 'Comprar tickets',
            ),
          ],
        ));
  }

  void logout(BuildContext context) async {
    //cerrar sesion en firebase
    await FirebaseAuth.instance.signOut();

    //borrar user email de shared preferences
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('userEmail');

    //redirigir al login
    MaterialPageRoute route =
        MaterialPageRoute(builder: ((context) => Login()));
    Navigator.pushReplacement(context, route);
  }
}



// Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(kBackgroundColor),
//         title: Text('Cliente Page'),
//         actions: [
//           Row(
//             children: [
//               Text(FirebaseAuth.instance.currentUser!.email!),
//               ElevatedButton(
//                   onPressed: () {
//                     AuthService().signOut();
//                   },
//                   child: Icon(MdiIcons.exitRun)),
//             ],
//           )
//         ],
//       ),
//       backgroundColor: Colors.grey[200],
//       body: ListView(
//           itemExtent: 250,
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           children: [
//             Events(
//                 titulo: 'Comprar',
//                 imagen: 'assets/images/pluma.jpg',
//                 onPressed: () {
//                   MaterialPageRoute route =
//                       MaterialPageRoute(builder: ((context) => EventPage()));
//                   Navigator.push(context, route);
//                 }),
//             Events(
//                 titulo: 'Noticias',
//                 imagen: 'assets/images/bird.jpg',
//                 onPressed: () {
//                   MaterialPageRoute route = MaterialPageRoute(
//                       builder: ((context) => ClienteNoticias()));
//                   Navigator.push(context, route);
//                 }),
//             Events(
//                 titulo: 'Mis tickets',
//                 imagen: 'assets/images/Woman.jpg',
//                 onPressed: () {
//                   MaterialPageRoute route =
//                       MaterialPageRoute(builder: ((context) => EventPage()));
//                   Navigator.push(context, route);
//                 }),
//           ]),
//     )