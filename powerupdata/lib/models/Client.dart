import 'package:cloud_firestore/cloud_firestore.dart';

class Client{
  String nombre;
  String? telefono;
  double importe;
  bool matricula;
  Timestamp fechaMatricula;
  String admin;

  Client({
    required this.nombre,
    required this.importe,
    this.telefono,
    required this.matricula,
    required this.fechaMatricula,
    required this.admin
  });

  @override
  String toString() {
    return 'Client{nombre: $nombre,importe: $importe telefono: $telefono, matricula: $matricula, fechaMatricula: $fechaMatricula, admin: $admin }';
  }

  static Client fromFirestore(DocumentSnapshot document) {
  return Client(
    nombre: document['nombre'],
    importe: document['importe'],
    telefono: document['tel'],
    matricula: document['matricula'],
    fechaMatricula: document['fechaMatricula'],
    admin: document['inscrito por'],
  );
}

}