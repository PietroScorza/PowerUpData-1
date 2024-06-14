import 'dart:ffi';

class Client{
  int id;
  String nombre;
  String? telefono;
  Double? importe;
  bool matricula;
  DateTime fechaMatricula;

  Client({
    required this.id,
    required this.nombre,
    this.importe,
    this.telefono,
    required this.matricula,
    required this.fechaMatricula,
  });

  @override
  String toString() {
    return 'Client{id: $id, nombre: $nombre,importe: $importe telefono: $telefono, matricula: $matricula, fechaMatricula: $fechaMatricula}';
  }


  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      nombre: json['nombre'],
      telefono: json['telefono'],
      importe: json['importe'],
      matricula: json['matricula'],
      fechaMatricula: DateTime.parse(json['fechaMatricula']),
    );
  }


Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'telefono': telefono,
      'importe': importe,
      'matricula': matricula,
      'fechaMatricula': fechaMatricula.toIso8601String(),
    };
  }
}