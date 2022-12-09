import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_movil/providers/eventos_provider.dart';
import 'package:proyecto_movil/pages/admin/admin_agregar_eventos.dart';
import 'package:proyecto_movil/pages/admin/admin_editar_eventos.dart';
import 'package:proyecto_movil/pages/cliente/cliente_agregar_entradas.dart';

class ClienteEventosListarPage extends StatefulWidget {
  const ClienteEventosListarPage({Key? key}) : super(key: key);

  @override
  State<ClienteEventosListarPage> createState() =>
      _ClienteEventosListarPageState();
}

class _ClienteEventosListarPageState extends State<ClienteEventosListarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: EventosProvider().getEventos(toString()),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              thickness: 1.3,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              var evento = snapshot.data[index];
              if (evento['estado_evento'] == 'Proximo') {
                return Slidable(
                  child: ListTile(
                    leading: Icon(MdiIcons.cube),
                    title: Text('${evento['nombre_evento']}'),
                    subtitle: Text('Estado: ${evento['estado_evento']}'),
                    trailing: Text(
                        'Entradas vendidas: ${evento['entradas_vendidas']}'),
                    onLongPress: () {
                      //editar

                      MaterialPageRoute route = MaterialPageRoute(
                          builder: ((context) =>
                              EntradasAgregarPage(evento['id_evento'])));
                      Navigator.push(context, route).then((value) {
                        setState(() {});
                      });

                      // MaterialPageRoute route = MaterialPageRoute(
                      //   builder: (context) =>
                      //       EntradasAgregarPage(evento['id_evento']),
                      // );
                      // Navigator.push(context, route).then((valor) {
                      //   setState(() {
                      //     MaterialPageRoute route = MaterialPageRoute(
                      //       builder: (context) => ClienteEventosListarPage(),
                      //     );
                      //     Navigator.push(context, route).then((value) {
                      //       setState(() {});
                      //     });
                      //   });
                      // });
                    },
                  ),
                );
              } else {
                return Text('');
              }
              ;
            },
          );
        },
      ),
    );
  }
}
