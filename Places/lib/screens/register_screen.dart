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

  // 📌 Controladores: las claves son los nombres que se envían al backend
  final Map<String, TextEditingController> controllers = {
    'nombres': TextEditingController(),
    'primer_apellido': TextEditingController(),
    'segundo_apellido': TextEditingController(), // opcional
    'ci': TextEditingController(),
    'complemento': TextEditingController(),      // opcional
    'fecha_nacimiento': TextEditingController(),
    'genero': TextEditingController(),
    'direccion': TextEditingController(),
    'telefono_fijo': TextEditingController(),    // opcional
    'email': TextEditingController(),
    'celular': TextEditingController(),
    'name_usuario': TextEditingController(),
    'contrasena': TextEditingController(),
  };

  // 📌 Etiquetas: lo que se muestra al usuario en pantalla
  final Map<String, String> labels = {
    'nombres': 'Nombres',
    'primer_apellido': 'Primer apellido',
    'segundo_apellido': 'Segundo apellido (opcional)',
    'ci': 'Carnet de identidad',
    'complemento': 'Complemento (opcional)',
    'fecha_nacimiento': 'Fecha de nacimiento (formato año-mes-día)',
    'genero': 'Género',
    'direccion': 'Dirección',
    'telefono_fijo': 'Teléfono fijo (opcional)',
    'email': 'Correo electrónico',
    'celular': 'Celular',
    'name_usuario': 'Nombre de usuario',
    'contrasena': 'Contraseña',
  };

  bool _loading = false;

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final url = Uri.parse('${getBaseUrl()}/api/register');

    // 📌 Construir body con valores vacíos correctos
    final Map<String, dynamic> body = controllers.map((k, v) => MapEntry(k, v.text.trim()));

    // Forzar valores vacíos según tipo
    if (body['segundo_apellido'] == null || body['segundo_apellido'].isEmpty) {
      body['segundo_apellido'] = ""; // VARCHAR vacío
    }
    if (body['complemento'] == null || body['complemento'].isEmpty) {
      body['complemento'] = ""; // VARCHAR vacío
    }
    if (body['telefono_fijo'] == null || body['telefono_fijo'].isEmpty) {
      body['telefono_fijo'] = 0; // INT vacío → 0
    }

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    setState(() => _loading = false);

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
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
        title: const Text(
          'Registrar nuevo usuario',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: const Color(0xFF4A148C),
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
                            labelText: labels[entry.key],
                            border: const OutlineInputBorder(),
                          ),
                          validator: (v) {
                            // ⚠️ Solo estos tres campos pueden quedar vacíos
                            if (['segundo_apellido', 'complemento', 'telefono_fijo']
                                .contains(entry.key)) {
                              return null; // no obligatorio
                            }
                            if (v == null || v.trim().isEmpty) {
                              return 'Introduce ${labels[entry.key]}';
                            }
                            // Validación contraseña → mínimo 6 caracteres
                            if (entry.key == 'contrasena' && v.length < 6) {
                              return 'La contraseña debe tener al menos 6 caracteres';
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
