import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:powerupdata/models/Client.dart';

class FirestoreService {
  final CollectionReference clientsCollection = FirebaseFirestore.instance.collection('clients');

  Future<void> createClient(
    String name, double importe, String? tel, bool matricula,Timestamp fechaMatricula, String inscritopor, int mesesMatriculado) {
    try {
      return clientsCollection.add({
        'nombre': name,
        'importe': importe,
        'tel': tel,
        'matricula': matricula,
        'fechaMatricula': fechaMatricula,
        'inscrito por':  inscritopor,
        'mesesMatriculado': mesesMatriculado,
        'fechaCreacion': Timestamp.now(),
             });
    } catch (e) {
      throw Exception('Error al crear el cliente');
    }
  }

  Stream<QuerySnapshot> getClients() {
    final clientsStream = clientsCollection.orderBy('nombre', descending: true).snapshots();
    return clientsStream;
  }

  Future<void> deleteClient(String id) {
    try {
      return clientsCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Error al eliminar el cliente');
    }
  }

  //cambiar estado de la matricula

  Future<void> updateMatricula(Client c){
    if (c.matricula == false){
      try {
        return clientsCollection.doc(c.id).update({
          'fechaMatricula': Timestamp.now(),
          'matricula': true,
          
        });
      } catch (e) {
        throw Exception('Error al matricular el cliente');
      }
    }else{ 
      try {
        return clientsCollection.doc(c.id).update({
          'matricula': false,
          'importe': 0.0,
        });
      } catch (e) {
        throw Exception('Error al desmatricular el cliente');
      }
    }
  }

  Future<void> updateImporteAndMonths(Client c){
    try {
      return clientsCollection.doc(c.id).update({
        'importe': c.importe,
        'mesesMatriculado': c.mesesMatriculado,
      });
    } catch (e) {
      throw Exception('Error al actualizar el importe');
    }
  }

  Future<void> sinDias(String id){
    try {
      return clientsCollection.doc(id).update({
        'matricula': false,
        'importe': 0.0,
      });
    } catch (e) {
      throw Exception('Error al desmatricular el cliente');
    }
  }

}



