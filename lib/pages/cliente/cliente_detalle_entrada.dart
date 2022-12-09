import 'package:flutter/material.dart';
import 'package:proyecto_movil/providers/entradas_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
class EntradaDetallePage extends StatefulWidget {
  final String numero_entrada;
  EntradaDetallePage(this.numero_entrada, {Key? key}) : super(key: key);

  @override
  State<EntradaDetallePage> createState() => _EntradaDetallePageState();
}
class _EntradaDetallePageState extends State<EntradaDetallePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de la entrada'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: EntradasProvider().getEntrada(widget.numero_entrada),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var entrada = snapshot.data;
              String qrData = "http://www.usmentradas.cl/" + widget.numero_entrada.toString();
              return Form(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          
                          Text('El numero de entrada es: ' + entrada['numero_entrada'].toString()),
                          Text('El nombre del cliente es: ' + entrada['nombre_cliente'].toString()),
                          Text('El evento es: ' + entrada['evento_id'].toString()),
                          Text('La informacion del evento: '),
                          Text(entrada['informacion_evento'].toString()),
                          QrImage(data: qrData)
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}