import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'forgot_password_screen.dart';
import '../utils/api_config.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  bool _loading = false;

  Future<void> login() async {
    setState(() => _loading = true);

    final url = Uri.parse('${getBaseUrl()}/api/login'); //sirve para conectar la base de datos en multiplataforma
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name_usuario': usuarioController.text,
        'contrasena': contrasenaController.text,
      }),
    );

    setState(() => _loading = false);

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login exitoso ✅')),
      );
      print('Token: ${data['token']}');
      Navigator.of(context).pushReplacementNamed('/home'); // 🔄 Navega a Home
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${data['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF5A4FCF), // 💠 azul con toque morado
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: usuarioController,
                      decoration: const InputDecoration(
                        labelText: 'Usuario o correo',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Introduce tu usuario';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: contrasenaController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Introduce tu contraseña';
                        if (v.length < 6) return 'La contraseña debe tener al menos 6 caracteres';
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                          );
                        },
                        child: const Text('¿Olvidó su contraseña?'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _loading ? null : login,
                        child: _loading
                            ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                            : const Text('Entrar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
