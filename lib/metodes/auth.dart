import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:powerupdata/widgets/hidden_drawer.dart';
import 'package:powerupdata/screens/LoginPage.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
        if (snapshot.hasData) {
          return  const HiddenDrawer();
        }else{
        return LoginPage();
        }
      },
    )
    );
  }
}