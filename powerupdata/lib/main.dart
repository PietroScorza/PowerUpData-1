import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:powerupdata/metodes/auth.dart';
import 'package:powerupdata/screens/HomePage.dart';
import 'package:powerupdata/screens/LoginPage.dart';
import 'package:powerupdata/theme/dark_theme.dart';
import 'package:powerupdata/theme/light_theme.dart';
import 'firebase_options.dart';
import 'package:powerupdata/screens/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PowerUpData',
      theme: lightMode, 
      darkTheme: darkMode,
        initialRoute: Routes.auth,
        routes: {
          Routes.home: (context) => HomePage(),
          Routes.login: (context) => LoginPage(),
          Routes.auth: (context) => Auth(),
        },
    );
  }
}