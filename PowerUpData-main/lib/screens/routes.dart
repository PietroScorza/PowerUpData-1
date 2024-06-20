import 'package:flutter/material.dart';
import 'package:powerupdata/metodes/auth.dart';
import 'package:powerupdata/screens/HomePage.dart';
import 'package:powerupdata/screens/LoginPage.dart';

class Routes{
static const String home = 'home';
static const String login = 'login';
static const String auth = 'auth';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case login:
       return MaterialPageRoute(builder: (_) => LoginPage());
      case auth:
        return MaterialPageRoute(builder: (_) => Auth()); 
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
        
  }

  }
}

