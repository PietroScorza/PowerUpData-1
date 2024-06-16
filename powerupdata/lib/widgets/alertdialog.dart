import 'package:flutter/material.dart';
import 'package:powerupdata/metodes/Comprovaciones.dart';
import 'package:powerupdata/metodes/firestore.dart';
import 'package:powerupdata/metodes/withoutExepcion.dart';
import 'package:powerupdata/models/Client.dart';

void displayMessage(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Message'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}


void displayMessageDelete(BuildContext context, String message, Client client) {
  FirestoreService firebase = FirestoreService();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Seguro que quieres eliminar el cliente?'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              firebase.deleteClient(client.id!);
              Navigator.of(context).pop();
            },
            child: Text('Si', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('no', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
          ),
        ],
      );
    },
  );
}

void displayMessageDesmatricular(BuildContext context, String message, Client client) {
  FirestoreService firebase = FirestoreService();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: client.matricula ? Text("Quieres Desmatricular a ${client.nombre}?") : Text("Quieres matricular a ${client.nombre}?"),
        content: Text(message),
        actions: [ client.matricula ? 
        TextButton(
            onPressed: () {
              firebase.updateMatricula(client);
              Navigator.of(context).pop();

            },
            child: Text('Si', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
          ) :
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              selectImportandMonth(context, client);

            },
            child: Text('Si', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('no', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
          ),
        ],
      );
    },
  );
}

void selectImportandMonth(BuildContext context, Client client) {
  FirestoreService firebase = FirestoreService();
  TextEditingController importeController = TextEditingController();
  TextEditingController mesesController = TextEditingController();
  String errorMessage = '';

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {

          return AlertDialog(
            title: Text('Introduce el importe y los meses'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: importeController,
                  decoration: InputDecoration(
                    labelText: 'Importe',
                  ),
                ),
                TextField(
                  controller: mesesController,
                  decoration: InputDecoration(
                    labelText: 'Meses',
                  ),
                ),
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (importeController.text.isEmpty || mesesController.text.isEmpty) {
                    setState(() {
                      errorMessage = 'Has de rellenar todos los campos';
                    });
                  } else {
                    try {
                      client.setImport(Comprovaciones.pasarDouble(importeController.text));
                      client.setMesesMatriculado(Comprovaciones.pasarInt(mesesController.text));
                      firebase.updateImporteAndMonths(client);
                      firebase.updateMatricula(client);
                      Navigator.of(context).pop();
                    } catch (e) {
                      setState(() {
                        errorMessage = withoutExepcion(e.toString());
                      });
                    }
                  }
                },
                child: Text(
                  'Si',
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'no',
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
