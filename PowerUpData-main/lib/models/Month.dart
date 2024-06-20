import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:powerupdata/metodes/firestore.dart';
import 'package:powerupdata/models/Client.dart';

class Month {
  String name;
  double ingresTotal;
  List<DocumentReference> clientsMes;
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
  static int getDaysInMonth(String data) {

    List<String> parts = data.split(' ');
    int year = int.parse(parts[1]);
    List<String> mesesTreintaYUno = ['Enero', 'Marzo', 'Mayo', 'Julio', 'Agosto', 'Octubre', 'Diciembre'];
    List<String> mesesTreinta= ["Abril", "Junio" , "Septiembre", "Noviembre"];

    // Enero, Marzo, Mayo, Julio, Agosto, Octubre y Diciembre tienen 31 días
    for (var month in mesesTreintaYUno) {
      if (parts[0].contains(month)) {
        return 31;
      }
    }
  
  // Abril, , Septiembre y Noviembre tienen 30 días
for (var month in mesesTreinta) {
      if (parts[0].contains(month) ) {
        return 30;
      } 
  }
  
  // Febrero tiene 28 días, 29 en años bisiestos
  if (parts[0].contains("Febrero")) {
    // Un año es bisiesto si es divisible por 4, pero no por 100, a menos que también sea divisible por 400
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
      return 29;
    } else {
      return 28;
    }
  }
  
  // Si el mes no es válido, retornar 0
  return 0;
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
  static Month fromFirestore(DocumentSnapshot document) {

     Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Convertir la lista de referencias a documentos
    List<dynamic> clientsRefs = data['clientsMes'] ?? [];
    List<DocumentReference> references = [];

    for (var ref in clientsRefs) {
      if (ref is DocumentReference) {
        references.add(ref);
      } else if (ref is String) {
        references.add(FirebaseFirestore.instance.doc(ref));
      }
    }
    return Month(
      name: document['nombre'],
      ingresTotal: document['ingresTotal'],
      clientsMes: references,
      days: document['days'],
    );
  }

  Future<List<Client>> getClientes() async {
    FirestoreService  firestoreService = FirestoreService();
    return  firestoreService.getClientsFromids(clientsMes);

  }


}