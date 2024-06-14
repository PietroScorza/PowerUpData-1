import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:powerupdata/metodes/firestore.dart';
import 'package:powerupdata/models/Client.dart';

class HomePage extends StatelessWidget {
  
  const HomePage({super.key});

  @override

  Widget build(BuildContext context) {
    FirestoreService firestoreService = FirestoreService();

    return StreamBuilder<QuerySnapshot>(
    stream: firestoreService.getClients(),
    builder: (context, snapshot){
      if(snapshot.hasData){
        
        return Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              var client = snapshot.data!.docs[index];
              Client clientData = Client.fromFirestore(client);
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(185, 187, 120, 58),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(clientData.nombre),
                    subtitle: Text(clientData.importe.toString()),
                    trailing: Text(clientData.fechaMatricula.toDate().toString()),
                  ),
                ),
              );
            },
          ),
        );
      }else{
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
    );
      }
}