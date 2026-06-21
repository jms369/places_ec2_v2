import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:places/search_places.dart';

import 'home.dart';
import 'profile_screen.dart'; // ✅ Import directo de ProfileScreen

class PlacesCupertino extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final places = Scaffold(
      bottomNavigationBar: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Colors.white.withAlpha(50),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home, color: Color(0xFF574ACF))),
            BottomNavigationBarItem(icon: Icon(Icons.search, color: Color(0xFF574ACF))),
            BottomNavigationBarItem(icon: Icon(Icons.person, color: Color(0xFF574ACF))),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          CupertinoTabView cupertinoTabView;

          switch (index) {
            case 0:
              cupertinoTabView = CupertinoTabView(builder: (BuildContext context) => MyHome());
              break;
            case 1:
              cupertinoTabView = CupertinoTabView(builder: (BuildContext context) => SearchPlaces());
              break;
            case 2:
              cupertinoTabView = CupertinoTabView(
                builder: (BuildContext context) => ProfileTabPlaceholderCupertino(), // 🔄 CAMBIO
              );
              break;
            default:
              cupertinoTabView = CupertinoTabView(builder: (BuildContext context) => MyHome());
              break;
          }

          return cupertinoTabView;
        },
      ),
    );
    return places;
  }
}

// 🔄 NUEVO: placeholder para el tab de perfil en Cupertino
class ProfileTabPlaceholderCupertino extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoButton(
        color: const Color(0xFF574ACF),
        onPressed: () {
          // ✅ Abre ProfileScreen como ruta aparte
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (_) => const ProfileScreen()),
          );
        },
        child: const Text("Ir a perfil"),
      ),
    );
  }
}

