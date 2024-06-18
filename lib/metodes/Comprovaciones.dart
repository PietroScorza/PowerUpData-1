
class Comprovaciones{

  static double pasarDouble(String text) {
    if (text.isEmpty ) {
      return 0.0;
    }

    try {
      double numero = double.parse(text);

      if (numero < 0) {
        throw Exception('El importe no puede ser negativo');
      }
      return double.parse(text);
    } catch (e) {
      throw Exception('El importe no es un número');
    }
  }

  static bool matriculat(String _controllerImport){
    
    if (pasarDouble(_controllerImport) != 0){
      return true;
    }
    return false;
  }
  
  static int pasarInt(String text) {
    if (text.isEmpty) {
      return 1;
    }

    try {
      int numero = int.parse(text);

      if (numero < 0) {
        throw Exception('El importe no puede ser negativo');
      }
      return numero;
    } catch (e) {
      throw Exception('Los meses deben ser un numero número');
    }
  }

}