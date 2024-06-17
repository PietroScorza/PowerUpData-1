import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:powerupdata/metodes/firestore.dart';
import 'package:powerupdata/models/Month.dart';
import 'package:powerupdata/theme/MyTextStyle.dart';

// ignore: must_be_immutable
class Page1 extends StatelessWidget {
  final String nombreMes;

  Page1(this.nombreMes) : super();

  FirestoreService firestore = FirestoreService();
  

  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot?>(
      future: firestore.getMes(nombreMes),
      builder: (context, snapshot) {
        print(nombreMes);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data == null) {
          Month mes = Month();
          return Center(child: Text('No se encontró el documento.'));
        }else{
        Month mes = Month.fromFirestore(snapshot.data!);

        return Scaffold(
          body: Padding(
            padding: EdgeInsets.fromLTRB(40, 40, 40, 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.grey[900],
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 18.0),
                        child: Text(mes.name , style: MyTextStyle(context, 30, color: Colors.white),),
                      ),
        
                      Divider(color: Colors.white, thickness: 2),
        
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8 , 0, 8 ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                                      
                          Text('Ingresos', style: MyTextStyle(context, 20, color: Colors.white),),
                          Text('Clientes', style: MyTextStyle(context, 20, color: Colors.white),),
                        ],
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          Text("mes.ingres.toString()", style: MyTextStyle(context, 20, color: Colors.white),),
                          TextButton(child: Text("clientsMes".toString(), style: MyTextStyle(context, 20, color: Colors.white)), onPressed: () {
                                  },),
                        ],)
                    ],
                  )
                  ),
                ),
              ),
            ),
          );
        }}
    );
    
  }
}