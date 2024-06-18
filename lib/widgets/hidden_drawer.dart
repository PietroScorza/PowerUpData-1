import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:powerupdata/screens/SettingsPage.dart';
import 'package:powerupdata/widgets/BottomNav.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Inicio',
          baseStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18.0),
          colorLineSelected: Theme.of(context).colorScheme.onSecondary,
          selectedStyle: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 18.0),
        ),
        const BottomNavBar(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Configuracion',
          baseStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 18.0),
          colorLineSelected: Theme.of(context).colorScheme.onSecondary,
          selectedStyle: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 18.0),
        ),
        const SettingPage(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      withShadow: true,
      isTitleCentered: true,
      elevationAppBar: 4.0,
      backgroundColorMenu: Theme.of(context).colorScheme.inversePrimary,
      screens: _pages,
      initPositionSelected: 0,
    );
  }
}

