import 'package:flutter/material.dart';

class appbar_login extends StatelessWidget implements PreferredSizeWidget {
  const appbar_login({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Center(
        child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'PowerUp',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
              TextSpan(
                text: 'Data',
                style: TextStyle(color: Colors.orange, fontSize: 15.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class my_appbar extends StatelessWidget implements PreferredSizeWidget {
  const my_appbar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 20.0,
      title: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'PowerUp',
                style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary, fontSize: 25.0),
              ),
              TextSpan(
                text: 'Data',
                style: TextStyle(color: Colors.orange, fontSize: 15.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}