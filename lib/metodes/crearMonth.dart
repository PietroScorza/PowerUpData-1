import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:powerupdata/metodes/firestore.dart';
import 'package:powerupdata/models/Client.dart';
import 'package:powerupdata/models/Month.dart';

Future<Month> autoCreate(String name) async {
    FirestoreService fire = FirestoreService();

    DateTime now = DateTime.now();
    List<Client> clients = [];
    List<DocumentSnapshot> cQuery;
    try{
    cQuery =  await fire.getDocumentSnapshots(fire.getClientsEspecific(name));
    
    for (DocumentSnapshot doc in cQuery){
      clients.add(Client.fromFirestore(doc));
    }
    }catch(e){
      print('Error al obtener el documento: $e');
    }
    return Month(
      name: name,
      ingresTotal: 0.0,
      clientsMes: clients,
      days: Month.getDaysInMonth(now.year, now.month),
    );
}