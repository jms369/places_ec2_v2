import 'package:flutter/material.dart';
import 'package:places/places.dart';
import 'package:places/places_cupertino.dart';
import 'home.dart';
import 'screens/login_screen.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(), // Pantalla inicial
        '/home': (context) => PlacesCupertino(), // Pantalla principal
        // ❌ Ruta '/profile' eliminada, ya no se necesita
      },
    );
  }
}
