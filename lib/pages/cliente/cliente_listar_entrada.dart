import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proyecto_movil/providers/entradas_provider.dart';
import 'package:proyecto_movil/pages/cliente/cliente_detalle_entrada.dart';
import 'package:proyecto_movil/pages/cliente/cliente_agregar_entradas.dart';

class EntradasListarPage extends StatefulWidget {
  const EntradasListarPage({Key? key}) : super(key: key);

  @override
  State<EntradasListarPage> createState() => _EntradasListarPageState();
}

class _EntradasListarPageState extends State<EntradasListarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: EntradasProvider().getEntradas(),
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
              var entrada = snapshot.data[index];

              return Slidable(
                //action panes
                //ListTile
                child: ListTile(
                  leading: Icon(MdiIcons.cube),
                  title: Text('${entrada['numero_entrada']}'),
                  subtitle: Text('Evento: ${entrada['evento_id']}'),
                  trailing:
                      Text('Nombre del cliente: ${entrada['nombre_cliente']}'),
                  onLongPress: () {
                    //editar

                    MaterialPageRoute route = MaterialPageRoute(
                        builder: ((context) =>
                            EntradaDetallePage(entrada['numero_entrada'])));
                    Navigator.push(context, route).then((value) {
                      setState(() {});
                    });

                    // MaterialPageRoute route = MaterialPageRoute(
                    //   builder: (context) =>
                    //       EntradaDetallePage(entrada['numero_entrada']),
                    // );
                    // Navigator.push(context, route).then((valor) {
                    //   setState(() {
                    //     MaterialPageRoute route = MaterialPageRoute(
                    //       builder: (context) => EntradasListarPage(),
                    //     );
                    //     Navigator.push(context, route).then((value) {
                    //       setState(() {});
                    //     });
                    //   });
                    // });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
