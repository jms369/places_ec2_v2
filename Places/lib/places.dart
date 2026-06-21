import 'package:flutter/material.dart';
import 'package:places/search_places.dart';

import 'home.dart';
import 'profile_screen.dart'; // ✅ Import directo de ProfileScreen

class Places extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Places();
  }
}

class _Places extends State<Places> {
  int currentIndex = 0;

  List<Widget> pantallas = <Widget>[
    MyHome(),
    SearchPlaces(),
    ProfileTabPlaceholder(), // 🔄 CAMBIO: tab de perfil vuelve a ser un contenedor simple
  ];

  void cambiarPantalla(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: const Color(0xFF574ACF),
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home, color: Color(0xFF574ACF)), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.search, color: Color(0xFF574ACF)), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.person, color: Color(0xFF574ACF)), label: ""),
          ],
          onTap: cambiarPantalla,
          currentIndex: currentIndex,
        ),
      ),
      body: pantallas[currentIndex],
    );

    return scaffold;
  }
}

// 🔄 NUEVO: placeholder para el tab de perfil
class ProfileTabPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // ✅ Abre ProfileScreen como ruta aparte
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          );
        },
        child: const Text("Ir a perfil"),
      ),
    );
  }
}
