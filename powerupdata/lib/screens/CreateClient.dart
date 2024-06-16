import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:powerupdata/metodes/Comprovaciones.dart';
import 'package:powerupdata/metodes/firestore.dart';
import 'package:powerupdata/metodes/withoutExepcion.dart';
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
  final _controllerMeses = TextEditingController();
  final firebase = FirestoreService();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Client'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/createbackground.jpeg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.darken),
              ),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Image(
                            image: AssetImage('assets/images/user.webp'),
                            width: 200,
                            height: 200,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(45, 20, 45, 20),
                    child: ClipRRect(
                      
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Image
                              
                          
                              // Textfield Name and Import
                              SizedBox(
                                  width: 200,
                                  child: MyTextField(
                                      hintText: "Nombre",
                                      obscureText: false,
                                      controller: _controllerName)),
                              const Padding(padding: EdgeInsets.all(20)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 95,
                                      child: MyTextField(
                                          hintText: "Meses",
                                          obscureText: false,
                                          controller: _controllerMeses)),
                                  Padding(padding: EdgeInsets.all(10)),
                                  SizedBox(
                                      width: 95,
                                      child: MyTextField(
                                          hintText: "Importe",
                                          obscureText: false,
                                          controller: _controllerImport)),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.all(10)),
                              SizedBox(
                                  width: 200,
                                  child: MyTextField(
                                      hintText: "Telefono (opcional)",
                                      obscureText: false,
                                      controller: _controllerTel)),
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
                                child: TextButton(
                                    onPressed: crearCliente,
                                    child: const Text('Crear Cliente')),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void crearCliente() {
    if (_controllerName.text.isEmpty || _controllerMeses.text.isEmpty) {
      displayMessage(context, 'Rellena todos los campos');
      return;
    }

    try {
      Client c = Client(
        nombre: _controllerName.text,
        importe: Comprovaciones.pasarDouble(_controllerImport.text),
        telefono: _controllerTel.text,
        mesesMatriculado: Comprovaciones.pasarInt(_controllerMeses.text),
        matricula: Comprovaciones.matriculat(_controllerImport.text),
        fechaMatricula: Timestamp.now(),
        admin: user!.email!,
        fechaCreacion: Timestamp.now(),
      );

      firebase.createClient(c.nombre, c.importe, c.telefono, c.matricula,
          c.fechaMatricula, c.admin, c.mesesMatriculado);

      _controllerImport.clear();
      _controllerName.clear();
      _controllerTel.clear();
      _controllerMeses.clear();
      c.matricula
          ? messageAlert(context, "Usuario creado con matricula")
          : messageAlert(context, "Usuario creado sin matricula");
    } catch (e) {
      displayMessage(context, withoutExepcion(e.toString()));
    }
  }
}
