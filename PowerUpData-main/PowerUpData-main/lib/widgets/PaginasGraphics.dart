import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:powerupdata/metodes/crearMonth.dart';
import 'package:powerupdata/metodes/firestore.dart';
import 'package:powerupdata/models/Client.dart';
import 'package:powerupdata/models/Month.dart';
import 'package:powerupdata/theme/MyTextStyle.dart';
import 'package:powerupdata/widgets/puntuales/DayliMonth.dart';

// ignore: must_be_immutable
class Page1 extends StatelessWidget {
  final String nombreMes;

  Page1(this.nombreMes, {super.key});

  FirestoreService firestore = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot?>(
        future: firestore.getMes(nombreMes),
        builder: (context, snapshot) {
          print(nombreMes);

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 1,
            ));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return FutureBuilder<Month>(
                future: autoCreate(nombreMes),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  mescreacion(snapshot.data!);
                  Month mes = snapshot.data!;

                  return ContinerDeMesesDatos(context, mes);
                });
          } else {
            Month mes = Month.fromFirestore(snapshot.data!);
            return ContinerDeMesesDatos(context, mes);
          }
        });
  }

  FutureBuilder<List<Client>> ContinerDeMesesDatos(
      BuildContext context, Month mes) {
    return FutureBuilder<List<Client>>(
        future: mes.getClientes(),
        builder: (context, AsyncSnapshot<List<Client>> snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData || snapshot.data != null){
          List<Client> clientsData = snapshot.data!;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.grey[900],
                  child: Center(
                      child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 18.0),
                        child: Text(
                          mes.name,
                          style: MyTextStyle(context, 30, color: Colors.white),
                        ),
                      ),
                      const Divider(color: Colors.white, thickness: 2),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'INGRESOS',
                                    style: MyTextStyle(context, 20,
                                        color: Colors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      mes.ingresTotal.toString(),
                                      style: MyTextStyle(context, 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'CLIENTES',
                                    style: MyTextStyle(context, 20,
                                        color: Colors.white),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      showCupertinoDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: const Text('Clientes'),
                                            content: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children:
                                                  clientsData.map((client) {
                                                return Text(
                                                  client.nombre,
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                );
                                              }).toList(),
                                            ),
                                            actions: [
                                              CupertinoDialogAction(
                                                child: const Text('Cerrar'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      clientsData.length.toString(),
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  )                   
                                ],
                              )
                            ],
                          )),
                     DayliMonth(mes.name, mes, clientsData ),

                    ],
                  )

                  
                  ),
                ),
              ),
            ),
          );}else {
            return const Center(
              child: Text('No hi ha dades'));
          }
          
        });
  }
}

void mescreacion(Month mes) async {
  FirestoreService firestore = FirestoreService();
  await firestore.createMonth(mes);
}
