import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:powerupdata/metodes/firestore.dart';
import 'package:powerupdata/models/Client.dart';

class Month {
  String name;
  double ingresTotal;
  List<Client> clientsMes;
  int days;

  Month({
    required this.name,
    required this.ingresTotal,
    required this.clientsMes,
    required this.days,
  });

  int numeroClientes(){
    return clientsMes.length;
  }

  // Método para obtener el número de días en el mes
  static int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  static String getMonthName(int month) {
    return _nombreEnEspanol(DateFormat.MMMM().format(DateTime(0, month)));
  }

  static String getYear(int year) {
    return year.toString();
  }

  static String _nombreEnEspanol(String mes){

    switch(mes){
      case 'January':
        return 'Enero';
      case 'February':
        return 'Febrero';
      case 'March':
        return 'Marzo';
      case 'April':
        return 'Abril';
      case 'May':
        return 'Mayo';
      case 'June':
        return 'Junio';
      case 'July':
        return 'Julio';
      case 'August':
        return 'Agosto';
      case 'September':
        return 'Septiembre';
      case 'October':
        return 'Octubre';
      case 'November':
        return 'Noviembre';
      case 'December':
        return 'Diciembre';
      default:
        return 'Error';
    }

  }


  static Month autoCreate(String name) async {
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
}