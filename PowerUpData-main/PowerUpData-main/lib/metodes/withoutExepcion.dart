String withoutExepcion(String excepcion){
  excepcion = excepcion.replaceAll('Exception: ', '');
  return excepcion;

}