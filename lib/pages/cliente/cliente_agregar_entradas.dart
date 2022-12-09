import 'package:flutter/material.dart';
import 'package:proyecto_movil/providers/entradas_provider.dart';
import 'package:proyecto_movil/providers/eventos_provider.dart';

class EntradasAgregarPage extends StatefulWidget {
  String id_evento;
  EntradasAgregarPage(this.id_evento, {Key? key}) : super(key: key);
  @override
  State<EntradasAgregarPage> createState() => _EntradasAgregarPageState();
}

class _EntradasAgregarPageState extends State<EntradasAgregarPage> {
  TextEditingController numero_entradaCtrl = TextEditingController();
  TextEditingController nombre_clienteCtrl = TextEditingController();
  TextEditingController informacion_eventoCtrl = TextEditingController();
  String errNumero_entrada = '';
  String errNombre_cliente = '';
  String errInformacion_cliente = '';
  int entradas_vendidasCtrl = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Entrada'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: EventosProvider().getEvento(widget.id_evento),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var evento = snapshot.data;
            entradas_vendidasCtrl = evento['entradas_vendidas'] + 1;
            return Form(
              child: ListView(
                children: [
                  campoNumero_entrada(),
                  mostrarError(errNumero_entrada),
                  campoNombre_cliente(),
                  mostrarError(errNombre_cliente),
                  campoInformacion_evento(),
                  mostrarError(errInformacion_cliente),
                  botonAgregar1(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Container mostrarError(String error) {
    return Container(
      width: double.infinity,
      child: Text(
        error,
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  TextFormField campoNumero_entrada() {
    return TextFormField(
      controller: numero_entradaCtrl,
      decoration: InputDecoration(
        labelText: 'numero_entrada',
      ),
      keyboardType: TextInputType.number,
    );
  }

  TextFormField campoInformacion_evento() {
    return TextFormField(
      controller: informacion_eventoCtrl,
      decoration: InputDecoration(
        labelText: 'informacion_evento',
      ),
    );
  }

  TextFormField campoNombre_cliente() {
    return TextFormField(
      controller: nombre_clienteCtrl,
      decoration: InputDecoration(
        labelText: 'Nombre_cliente',
      ),
    );
  }

  Container botonAgregar1() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.purple,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add),
            Text('Agregar Entranda'),
          ],
        ),
        onPressed: () async {
          String numero_entrada = numero_entradaCtrl.text.trim();
          String nombre_cliente = nombre_clienteCtrl.text.trim();
          String informacion_evento = informacion_eventoCtrl.text.trim();
          print(widget.id_evento);
          var respuesta = await EntradasProvider().agregar(numero_entrada,
              nombre_cliente, informacion_evento, widget.id_evento);
          await EventosProvider()
              .editar2(widget.id_evento, entradas_vendidasCtrl);
          if (respuesta['message'] != null) {
            var errores = respuesta['errors'];
            errNumero_entrada = errores['numero_entrada'] != null
                ? errores['numero_entrada'][0]
                : '';
            errNombre_cliente = errores['nombre_evento'] != null
                ? errores['nombre_evento'][0]
                : '';
            errInformacion_cliente = errores['informacion_evento'] != null
                ? errores['informacion_evento'][0]
                : '';
            setState(() {});
            return;
          }
          Navigator.pop(context);
        },
      ),
    );
  }
}
