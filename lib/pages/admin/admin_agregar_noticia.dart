import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_movil/constantes.dart';

import '../../services/firestore_service.dart';

class AgregarNoticia extends StatefulWidget {
  const AgregarNoticia({super.key});

  @override
  State<AgregarNoticia> createState() => _AgregarNoticiaState();
}

class _AgregarNoticiaState extends State<AgregarNoticia> {
  final formKey = GlobalKey<FormState>();
  bool val = false;
  int icono = 0;
  TextEditingController codigoCtrl = TextEditingController();
  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController cuerpoCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Noticia',style: kAppBarText,),
        backgroundColor: Color(kAppBar),
      ),
      backgroundColor: Color(kBackground2),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              FormsAdd(controll: codigoCtrl,text: 'Código',),
              SizedBox(height: 20,),
              FormsAdd(controll: tituloCtrl,text: 'Titulo',),
              SizedBox(height: 20,),
              FormsAdd(controll: cuerpoCtrl,text: 'Cuerpo',),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text('Noticia', style: TextStyle(fontSize: 18),),
                    CupertinoSwitch(
                      value: val,
                      onChanged: (value) {
                        if (value) {
                          setState(() {
                            val = true;
                            icono = 0;
                          });
                        } else {
                          setState(() {
                            val = false;
                            icono = 1;
                          });
                        }
                        print(icono);
                      },
                    ),
                    Text('Evento',style: TextStyle(fontSize: 18))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: double.infinity,
        height: 40,
        padding: EdgeInsets.only(left: 35),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(kBoton)),
          child: Text('Agregar Noticia',style: TextStyle(fontSize: 18),),
          onPressed: () {
            FirestoreService().agregar(
              codigoCtrl.text.trim(),
              tituloCtrl.text.trim(),
              cuerpoCtrl.text.trim(),
              icono,
            );
            print(icono);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class FormsAdd extends StatelessWidget {
  const FormsAdd({
    Key? key,
    required this.controll, required this.text,
  }) : super(key: key);

  final TextEditingController controll;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60),
          topLeft: Radius.circular(10))
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controll,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(fontSize: 18)
        ),
      ),
    );
  }
}
