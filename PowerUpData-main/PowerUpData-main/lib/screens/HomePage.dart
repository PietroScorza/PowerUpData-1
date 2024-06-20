import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:powerupdata/metodes/Comprovaciones.dart';
import 'package:powerupdata/metodes/firestore.dart';
import 'package:powerupdata/models/Client.dart';
import 'package:powerupdata/screens/DetailsClientPage.dart';
import 'package:powerupdata/screens/SearchScreen.dart';
import 'package:powerupdata/widgets/alertdialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    FirestoreService firestoreService = FirestoreService();

    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getClients(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Client> clientes = [];
          for (var doc in snapshot.data!.docs) {
            Client c = Client.fromFirestore(doc);
            clientes.add(c);
          }

          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var client = snapshot.data!.docs[index];
                      Client clientData = Client.fromFirestore(client);
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
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
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(clientes),
                      )),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const SearchBar(
                      autoFocus: false,
                      enabled: false,
                      leading: Icon(Icons.search),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
