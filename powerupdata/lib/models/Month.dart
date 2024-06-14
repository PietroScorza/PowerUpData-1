import 'package:intl/intl.dart';
import 'package:powerupdata/models/Client.dart';

class Month {
  String name;
  double? ingreso;
  List<Client>? clientsMes;
  int days;

  Month({
    required this.name,
    this.ingreso,
    this.clientsMes,
    required this.days,
  });

  // Método para obtener el número de días en el mes
  static int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  static String getMonthName(int month) {
    return DateFormat.MMM().format(DateTime(0, month));
  }
}
