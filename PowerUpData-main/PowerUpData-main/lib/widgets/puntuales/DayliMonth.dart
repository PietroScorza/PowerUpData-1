import 'package:flutter/material.dart';
import 'package:powerupdata/models/Client.dart';
import 'package:powerupdata/models/Month.dart';
import 'package:powerupdata/theme/MyTextStyle.dart';

class DayliMonth extends StatelessWidget {
  final String nombreMes;
  final Month mes;
  final List<Client> clientsMes;

  const DayliMonth(this.nombreMes, this.mes, this.clientsMes,{super.key, Key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28.0, 10, 28, 28),
      child: SizedBox(
          width: MediaQuery.of(context).size.width - 10,
          height: 185,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7),
              itemCount: mes.days,
              itemBuilder: (context, index) {
                List<Client> cs = clienteMatriculadoEseDia(index, clientsMes);
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: cs.isEmpty ? Colors.grey : Colors.green,
                      ),
                      width: 0.5,
                      height: 0.5,
                      child: Text(sumarDia(index).toString()),
                    ),
                    onTap: () {
                      
                      showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(
                          title: Text('Dia ${sumarDia(index)}'),
                          content: SingleChildScrollView(

                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height * 0.5,
                              ),
                              child: ListView.builder(
                                itemCount: cs.length,
                                itemBuilder: (context, index){
                                  return ListTile(
                                    title: Text(cs[index].nombre),
                                    subtitle: Text(cs[index].importe.toString(),),
                                  );
                                },
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child:  Text('OK', style: MyTextStyle(context, 15, color: Colors.orange)),
                            ),
                          ],
                        );
                      
                      }
                      );
                    },
                  ),
                );
              })),
    );
  }
 
}

int sumarDia(int indx) {
  return ++indx;
}

 List<Client> clienteMatriculadoEseDia(int index, List<Client> clientsMes) {
  List<Client> clientes = [];

  DateTime fechaDeMatriculacion;
  for (var client in clientsMes) {
    fechaDeMatriculacion = client.fechaMatricula.toDate();
    if (fechaDeMatriculacion.day == index+1) {
      clientes.add(client);
    }
  }
  return clientes;
  
}