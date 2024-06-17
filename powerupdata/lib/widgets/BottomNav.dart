import 'package:flutter/material.dart';
import 'package:powerupdata/screens/CreateClient.dart';
import 'package:powerupdata/screens/GraphicsPage.dart';
import 'package:powerupdata/screens/HomePage.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarExampleState createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // Lista de páginas disponibles
  final List<Widget> _pages = [
    const HomePage(),
    GraphicsPage(),
  ];

  // Método para cambiar de página
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Mostrar la página seleccionada
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        height: 60,
        color: Theme.of(context).colorScheme.primary,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              color: _selectedIndex == 0 ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.secondary,
              onPressed: () {
                _onItemTapped(0);
              },
            ),
            IconButton(
              icon: const Icon(Icons.bar_chart),
              color: _selectedIndex == 1 ? Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.secondary,
              onPressed: () {
                _onItemTapped(1);
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(4.0),
        child: FloatingActionButton(
          elevation: 2,
          hoverElevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          splashColor: Colors.orange,
          tooltip: 'Añade un cliente',
          onPressed: () {
                 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateClient()),
            );
          },
          child: Icon(Icons.person_add, color: Theme.of(context).colorScheme.inversePrimary,),
        ),
      ),
    );
  }
}
