import 'package:flutter/material.dart';
import 'package:powerupdata/models/Client.dart';
import 'package:powerupdata/theme/MyTextStyle.dart';

class DetailsClient extends StatelessWidget {
  final Client client;
  const DetailsClient({Key? key, required this.client}) : super(key: key);

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 119, 79, 66),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Detalles ${client.nombre}'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 8,
                spreadRadius: 2,
                offset: Offset(0, 0),
              ),
            ],
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(2),
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              Padding(padding: 
                const EdgeInsets.all(40.0),
                child: client.matricula ? Text("Matriculado", style: MyTextStyle(color: Colors.black, context, 25, fontWeight: FontWeight.bold)) : Text("No matriculado", style: MyTextStyle(color: Colors.black,context, 25, fontWeight: FontWeight.bold))
              ),
          
              Divider(indent: 80, endIndent: 80, thickness: 2, color: Theme.of(context).colorScheme.inversePrimary, height: 0),

              Padding(
                padding: const EdgeInsets.all(19.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                    
                    Text('Nombre', style: MyTextStyle(context, 12, fontWeight: FontWeight.normal, color: Colors.black)),
                    Text(client.nombre, style: MyTextStyle(context, 12, fontWeight: FontWeight.bold, color: Colors.black))
                      ],
                    ),
                    Column(
                      children: [
                    Text('Telefono', style: MyTextStyle(context, 12, color: Colors.black)),
                    client.telefono != "" ? Text(client.telefono!, style: MyTextStyle(context, 12, fontWeight: FontWeight.bold, color: Colors.black)) : Text('No disponible', style: MyTextStyle(color: Colors.black,context, 14, fontWeight: FontWeight.bold))
                           
                      ])

                    ]
                            ),
              ),
              Divider(indent: 80, endIndent: 80, thickness: 2, color: Theme.of(context).colorScheme.inversePrimary, height: 10),
              Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Importe: ", style: MyTextStyle(context,color: Colors.black, 16, fontWeight: FontWeight.bold)),
                  Text(client.importe.toString() + '€', style: MyTextStyle(color: Colors.black,context, 16, fontWeight: FontWeight.bold)),
                ],
              ),
              Padding(padding: EdgeInsets.all(8)),
              Text("Quedan " + client.diasRestantes().toString() + " dias", style: MyTextStyle(color: Colors.black,context, 16, fontWeight: FontWeight.bold)),
            
              Divider( indent: 50, endIndent: 50, thickness: 2, color: Theme.of(context).colorScheme.inversePrimary, height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Ultima de matriculación: ", style: MyTextStyle(context, 12,color: Colors.black, fontWeight: FontWeight.bold)),
                Text(client.getFechaMatricula(), style: MyTextStyle(context, 12, color: Colors.black,fontWeight: FontWeight.bold))
              ]),
              
              Padding(padding: EdgeInsets.all(8)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Inscrito por: ", style: MyTextStyle(context, 12,color: Colors.black, fontWeight: FontWeight.bold)),
                Text(client.admin, style: MyTextStyle(context, 12, color: Colors.black,fontWeight: FontWeight.bold))
              ]),

              Padding(padding: EdgeInsets.all(8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Fecha creacion: ", style: MyTextStyle(context, 12, fontWeight: FontWeight.bold, color: Colors.black)),
                Text(client.getFechaCreacion(), style: MyTextStyle(context, 12, fontWeight: FontWeight.bold,color: Colors.black))
              ]),

              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("ID: ", style: MyTextStyle(context, 12, fontWeight: FontWeight.bold, color: Colors.black)),
                Text(client.id!, style: MyTextStyle(context, 12, fontWeight: FontWeight.bold, color: Colors.black))
              ]),
              Padding(padding: EdgeInsets.all(8)),
              ],)
            
          ),
        ),
      );
  }
}