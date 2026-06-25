import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'utils/api_config.dart';
import 'screens/login_screen.dart';
import 'utils/user_session.dart'; // ✅ importamos la clase de sesión

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool _loading = false;

  Future<void> fetchUserData() async {
    setState(() => _loading = true);

    // ✅ usamos el idPersona real de la sesión
    final url = Uri.parse('${getBaseUrl()}/api/persona/${UserSession.idPersona}');
    final response = await http.get(url);

    setState(() => _loading = false);

    if (response.statusCode == 200) {
      setState(() => userData = jsonDecode(response.body));
      _showUserDataPopup();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al obtener los datos')),
      );
    }
  }

  void _showUserDataPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF5A4FCF),
          title: const Text(
            'Mis datos',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: userData == null
              ? const Text('No hay datos disponibles', style: TextStyle(color: Colors.white))
              : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: userData!.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    '${entry.key}: ${entry.value}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<void> logout() async {
    final url = Uri.parse('${getBaseUrl()}/api/logout');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        // ✅ limpiamos la sesión al cerrar
        UserSession.clear();

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al cerrar sesión')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error de conexión al cerrar sesión')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5A4FCF),
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: const Color(0xFF4A3FCF),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _loading ? null : fetchUserData,
                icon: const Icon(Icons.person),
                label: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Ver mis datos'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent[700],
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: logout,
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesión'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
