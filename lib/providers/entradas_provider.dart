import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class EntradasProvider {
  final apiURL = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> getEntradas() async {
    var respuesta = await http.get(Uri.parse(apiURL + '/entradas'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<LinkedHashMap<String, dynamic>> agregar(
      String numero_entrada,
      String nombre_cliente,
      String informacion_evento,
      String evento_id) async {
    var respuesta = await http.post(
      Uri.parse(apiURL + '/entradas'),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'numero_entrada': numero_entrada,
        'nombre_cliente': nombre_cliente,
        'informacion_evento': informacion_evento,
        'evento_id': evento_id,
      }),
    );

    return json.decode(respuesta.body);
  }

  //retorna los datos de 1 producto en particular
  Future<LinkedHashMap<String, dynamic>> getEntrada(
      String numero_entrada) async {
    var respuesta =
        await http.get(Uri.parse(apiURL + '/entradas/' + numero_entrada));
    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return LinkedHashMap();
    }
  }
}
