import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference clientsCollection = FirebaseFirestore.instance.collection('clients');

  Future<void> createClient(String name, double importe, String? tel, bool matricula,Timestamp fechaMatricula, String inscritopor) {
    try {
      return clientsCollection.add({
        'nombre': name,
        'importe': importe,
        'tel': tel,
        'matricula': matricula,
        'fechaMatricula': fechaMatricula,
        'inscrito por':  inscritopor,
             });
    } catch (e) {
      throw Exception('Error al crear el cliente');
    }
  }

  Stream<QuerySnapshot> getClients() {
    final clientsStream = clientsCollection.orderBy('nombre', descending: true).snapshots();
    return clientsStream;
  }
}


