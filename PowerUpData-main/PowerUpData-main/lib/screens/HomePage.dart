import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:powerupdata/metodes/SearchDelegate.dart';
import 'package:powerupdata/metodes/firestore.dart';
import 'package:powerupdata/models/Client.dart';
import 'package:powerupdata/widgets/MyListTitle.dart';

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
            padding: const EdgeInsets.only(top: 0.0),
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
                      return MyListTitle(clientData: clientData);
                    },
                  ),
                ),
                
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                    
                          color: Colors.blue[300]!,
                          borderRadius: BorderRadius.circular(10),
                      ),
                      height: 60,
                       child: IconButton(
                        splashColor: Colors.white,
                            onPressed: () {
                              showSearch(
                                  context: context, delegate: CustomSearchDelegate(clientes));
                            },
                            icon: const Icon(Icons.search),
                          ),
                      ),
                  ),
                
                
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
