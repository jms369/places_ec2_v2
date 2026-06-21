import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _sending = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendReset() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sending = true);
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _sending = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Instrucciones enviadas a ${_emailController.text}')),
      );
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Introduce tu correo para recibir instrucciones de recuperación.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Introduce tu correo';
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) return 'Correo no válido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _sending ? null : _sendReset,
                      child: _sending
                          ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : const Text('Enviar instrucciones'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
