import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:powerupdata/theme/MyTextStyle.dart';
import 'package:powerupdata/theme/ThemProvider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {



  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoSwitch(value: Provider.of<ThemeProvider>(context).isDarkMode, 
            onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme()),

            ElevatedButton(onPressed: (){
              FirebaseAuth.instance.signOut();
            }, child: Text('Cerrar session', style: MyTextStyle(context, 15)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onErrorContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          )
          ]
        ),
      )

    );
  }
}