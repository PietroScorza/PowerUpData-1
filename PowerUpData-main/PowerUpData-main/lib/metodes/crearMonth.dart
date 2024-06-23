import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:powerupdata/metodes/firestore.dart';
import 'package:powerupdata/models/Client.dart';
import 'package:powerupdata/models/Month.dart';

Future<Month> autoCreate(String name) async {
    FirestoreService fire = FirestoreService();

    List<DocumentReference> clients = [];
    List<Client> clientsList = [];
    List<DocumentSnapshot> cQuery;

    try{
    cQuery =  await fire.getDocumentSnapshots(fire.getClientsEspecific(name));
    
    for (DocumentSnapshot doc in cQuery){
      Client c = Client.fromFirestore(doc);
      if (c.matricula == true){
      clients.add(fire.clientsCollection.doc(c.id));
      clientsList.add(c);
      }
    }
    }catch(e){
      print('Error al obtener el documento: $e');
    }
    return Month(
      name: name,
      ingresTotal: calculartotal(clientsList),
      clientsMes: clients,
      days: Month.getDaysInMonth(name),
    );
}

double calculartotal(List<Client> clients){
  double total = 0.0;
  for (Client client in clients){
    total += client.importe;
  }
  return total;
}
