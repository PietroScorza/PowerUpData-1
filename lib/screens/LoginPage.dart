import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:powerupdata/widgets/AppBars.dart';
import 'package:powerupdata/widgets/alertdialog.dart';
import 'package:powerupdata/widgets/my_text_field.dart';

class LoginPage extends StatefulWidget {

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usuarioController = TextEditingController();

  final TextEditingController _contrasenaController = TextEditingController();

  void login() async{
    FirebaseAuth firebase = FirebaseAuth.instance;
 
    try {

      await firebase.signInWithEmailAndPassword(
        email: _usuarioController.text, password: _contrasenaController.text);


    } 
  
      on FirebaseException catch (e) {
          Navigator.pop(context);
        displayMessage(context, e.code);
      }
  }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const appbar_login(), // Utiliza el widget appbar_login como el appbar
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/loginbackground.jpeg',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.4),
              colorBlendMode: BlendMode.darken,
            ),
            Positioned.fill( // Envuelve el Container en Positioned.fill para que ocupe todo el espacio disponible
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 300, // Tamaño deseado del Container
                      width: 300, // Tamaño deseado del Container
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),                  
                      ),
                      
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: MyTextField(hintText: "Correo", obscureText: false, controller: _usuarioController,)
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: MyTextField(hintText: "Contraseña", obscureText: true, controller: _contrasenaController,)

                          ),


                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),  
                            onPressed: () {
                              login();
                            },
                            child: const Text('Login', style: TextStyle(color: Colors.black),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


