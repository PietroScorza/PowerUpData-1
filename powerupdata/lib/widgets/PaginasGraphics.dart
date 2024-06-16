import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.fromLTRB(40 , 40, 40, 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.blue,
          child: Center(
            child: Text('Page 1', style: TextStyle(color: Colors.white, fontSize: 30),),
          ),
        ),
      ),
      ),
      );    
  }
}