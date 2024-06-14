import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:powerupdata/metodes/firestore.dart';
import 'package:powerupdata/models/Client.dart';
import 'package:powerupdata/widgets/alertdialog.dart';
import 'package:powerupdata/widgets/my_snack_bar.dart';
import 'package:powerupdata/widgets/my_text_field.dart';

class CreateClient extends StatefulWidget {
  const CreateClient({super.key});

  @override
  State<CreateClient> createState() => _CreateClientState();
}

class _CreateClientState extends State<CreateClient> {
  final _controllerName = TextEditingController();
  final _controllerImport = TextEditingController();
  final _controllerTel = TextEditingController();
  final firebase = FirestoreService();
  User? user = FirebaseAuth.instance.currentUser;


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Create Client'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
          
            children: [
              //imagen
              Image(image: AssetImage('assets/images/user.webp'), width: 200, height: 200),
          
              //Textfield nomber i Importe
          
            SizedBox(
              width: 200,
              child: MyTextField(hintText: "Nombre", obscureText: false, controller: _controllerName)),
             const Padding(padding: EdgeInsets.all(20)),
             SizedBox(
              width: 200,
              child: MyTextField(hintText: "Importe", obscureText: false, controller: _controllerImport)),
              const Padding(padding: EdgeInsets.all(10))
          ,            SizedBox(
              width: 200,
              child: MyTextField(hintText: "Telefono", obscureText: false, controller: _controllerTel)),
            const Padding(padding: EdgeInsets.all(20)),
              Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(onPressed: crearCliente, child: const Text('Crear Cliente')))

            ],
          ),
        ),
      )
    );
  }

  void crearCliente(){
    if (_controllerName.text.isEmpty){
      displayMessage(context, 'Rellena todos los campos');
      return;
    }

    try{
    Client c = Client(
      nombre: _controllerName.text,
      importe: _pasarDouble(_controllerImport.text),
      telefono: _controllerTel.text,
      matricula: _matriculat(),
      fechaMatricula: Timestamp.now(),
      admin: user!.email!
    );

    firebase.createClient(c.nombre, c.importe, c.telefono, c.matricula, c.fechaMatricula ,c.admin);

    _controllerImport.clear();
    _controllerName.clear();
    _controllerTel.clear();
    c.matricula ? messageAlert(context, "Usuario creado con matricula") : messageAlert(context, "Usuario creado sin matricula");{
}
;

}catch(e){
  displayMessage(context, "El importe no es un numero");
}
  }


  double _pasarDouble(String text) {
    if (text.isEmpty) {
      return 0.0;
    }

    try {
      return double.parse(text);
    } catch (e) {
      throw Exception('El importe no es un número');
    }
  }

  bool _matriculat(){
    if (_pasarDouble(_controllerImport.text) != 0){
      return true;
    }
    return false;
  }

}