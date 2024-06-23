import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:powerupdata/metodes/Comprovaciones.dart';
import 'package:powerupdata/models/Client.dart';
import 'package:powerupdata/screens/DetailsClientPage.dart';
import 'package:powerupdata/widgets/alertdialog.dart';

class MyListTitle extends StatelessWidget {
  const MyListTitle({
    super.key,
    required this.clientData,
  });

  final Client clientData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                displayMessageDelete(
                    context, "Eliminnar Cliente", clientData);
              },
              icon: Icons.delete,
              backgroundColor: Colors.red[400]!,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            SlidableAction(
              autoClose: true,
              onPressed: (context) {
                displayMessageDesmatricular(
                    context, "", clientData);
              },
              borderRadius: BorderRadius.circular(5),
              backgroundColor: Colors.white,
              icon: clientData.matricula
                  ? Icons.close
                  : Icons.check,
              foregroundColor: clientData.matricula
                  ? Colors.red
                  : Colors.green,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: clientData.matricula
                ? Colors.white
                : const Color.fromARGB(255, 253, 164, 164),
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 2,
              ),
            ],
          ),
          child: ListTile(
              style: ListTileStyle.drawer,
              onLongPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailsClient(client: clientData),
                    ));
              },
              titleTextStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20),
              subtitleTextStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 15),
              leadingAndTrailingTextStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20),
              dense: false,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(clientData.nombre),
              ),
              subtitle: Comprovaciones.matriculat(
                      clientData.importe.toString())
                  ? Text("${clientData.importe}€")
                  : const Text("No matriculado"),
              trailing: Text(
                "${clientData.diasRestantes()} Restantes",
                style: const TextStyle(fontSize: 15),
              )),
        ),
      ),
    );
  }
}
