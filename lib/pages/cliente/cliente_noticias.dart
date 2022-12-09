import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_movil/constantes.dart';
import 'package:proyecto_movil/widgets/events.dart';
import 'package:proyecto_movil/widgets/imagen_fondo.dart';

import '../../services/firestore_service.dart';

class ClienteNoticias extends StatefulWidget {
  const ClienteNoticias({super.key});

  @override
  State<ClienteNoticias> createState() => _ClienteNoticiasState();
}

class _ClienteNoticiasState extends State<ClienteNoticias> {
  IconData icono = MdiIcons.cube;
  final imagen = 'assets/images/watercolor.jpg';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImagenFondo(imagen: imagen),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: StreamBuilder(
            stream: FirestoreService().listarNoticias(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.separated(
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) => Divider(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var noticia = snapshot.data!.docs[index];
                  if (noticia['tipo'] == 1) {
                    icono = MdiIcons.newspaperVariant;
                  } else {
                    icono = MdiIcons.stadium;
                  }
                  //print('PRODUCTO:' + producto.data().toString());
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: EdgeInsets.only(left:20,right: 20,top: 5),
                    height: 100,
                    child: 
                    ListTile(
                      leading: Icon(
                        icono,
                        size: 40,
                      ),
                      title: Text(noticia['titulo_noticia'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      subtitle: Text(noticia['cuerpo_noticia'], style: TextStyle(fontSize: 18),),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
