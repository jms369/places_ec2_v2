import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/api_config.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {
    'nombres': TextEditingController(),
    'primer_apellido': TextEditingController(),
    'segundo_apellido': TextEditingController(),
    'ci': TextEditingController(),
    'complemento': TextEditingController(),
    'fecha_nacimiento': TextEditingController(),
    'genero': TextEditingController(),
    'direccion': TextEditingController(),
    'telefono_fijo': TextEditingController(),
    'email': TextEditingController(),
    'celular': TextEditingController(),
    'name_usuario': TextEditingController(),
    'contrasena': TextEditingController(),
  };

  bool _loading = false;

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final url = Uri.parse('${getBaseUrl()}/api/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(controllers.map((k, v) => MapEntry(k, v.text))),
    );

    setState(() => _loading = false);

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso ✅')),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
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
        title: const Text('Registrar nuevo usuario'),
        centerTitle: true,
        backgroundColor: const Color(0xFF4A148C), // azul profundo con matiz morado
      ),
      backgroundColor: const Color(0xFF311B92),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ...controllers.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          controller: entry.value,
                          obscureText: entry.key == 'contrasena',
                          decoration: InputDecoration(
                            labelText: entry.key.replaceAll('_', ' ').toUpperCase(),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Introduce ${entry.key.replaceAll('_', ' ')}';
                            }
                            return null;
                          },
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.tealAccent[700],
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _loading ? null : register,
                        child: _loading
                            ? const CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
                            : const Text('Registrar'),
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
