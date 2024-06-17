import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:powerupdata/metodes/firestore.dart';
import 'package:powerupdata/models/Month.dart';

class Client{
  String? id = '';
  String nombre;
  String? telefono;
  double importe;
  bool matricula;
  int mesesMatriculado;
  Timestamp fechaMatricula;
  Timestamp fechaCreacion;
  String admin;
  String mesInscrito;

  Client({
    this.id,
    required this.nombre,
    required this.importe,
    this.telefono,
    required this.mesesMatriculado,
    required this.matricula,
    required this.fechaMatricula,
    required this.admin,
    required this.fechaCreacion,
    required this.mesInscrito
  });

  @override
  String toString() {
    return 'Client{nombre: $nombre,importe: $importe telefono: $telefono, mesesMatriculado $mesesMatriculado ,matricula: $matricula, fechaMatricula: $fechaMatricula, admin: $admin, fechaCreacion: $fechaCreacion, mesInscrito: $mesInscrito}';
  }

  static Client fromFirestore(DocumentSnapshot document) {
  return Client(
    id: document.id,
    nombre: document['nombre'],
    importe: document['importe'],
    telefono: document['tel'],
    mesesMatriculado: document['mesesMatriculado'],
    matricula: document['matricula'],
    fechaMatricula: document['fechaMatricula'],
    admin: document['inscrito por'],
    fechaCreacion: document['fechaCreacion'],
    mesInscrito: document['mesInscrito']
  );
}

void setImport(double import){
  importe = import;
}

void setMesesMatriculado(int meses){
  mesesMatriculado = meses;
}


  int diasRestantes(){
    FirestoreService firestoreService = FirestoreService();

    DateTime fechaActual = DateTime.now();
    DateTime fechaMatriculad = fechaMatricula.toDate();
    int diasRestantes = fechaMatriculad.difference(fechaActual).inDays;
    diasRestantes= diasRestantes + (mesesMatriculado * 30);

    if (diasRestantes <= 0){
      diasRestantes = 0;
      firestoreService.sinDias(id!);
    }

    return diasRestantes;
  }

  String getFechaMatricula(){
    DateTime fecha = fechaMatricula.toDate();
    return fecha.day.toString() + '/' + fecha.month.toString() + '/' + fecha.year.toString();
  }

  String getFechaCreacion(){
    DateTime fecha = fechaCreacion.toDate();
    return fecha.day.toString() + '/' + fecha.month.toString() + '/' + fecha.year.toString();
  }

    static String mesDeLaInscripcion(){
    DateTime fechaActual = DateTime.now();
    String mes = Month.getMonthName(fechaActual.month);

    String fechaCompleta = mes + ' ' + fechaActual.year.toString();
    return fechaCompleta;
  }

}