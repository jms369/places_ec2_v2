import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'utils/api_config.dart';
import 'utils/user_session.dart'; // ✅ nuevo import

class ComentariosGlobal extends StatefulWidget {
  const ComentariosGlobal({Key? key}) : super(key: key);

  @override
  State<ComentariosGlobal> createState() => _ComentariosGlobalState();
}

class _ComentariosGlobalState extends State<ComentariosGlobal> {
  final TextEditingController _controller = TextEditingController();
  List<String> comentarios = [];

  Future<void> enviarComentario() async {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;

    // ✅ Debug: mostramos en consola qué se está enviando
    print('Enviando comentario con id_personas=${UserSession.idPersona}, texto=$texto');//aqui termina el cambio de prueba

    final url = Uri.parse('${getBaseUrl()}/api/comentarios');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id_personas': UserSession.idPersona, // ✅ usamos el id real
        'comentario': texto,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        comentarios.insert(0, texto);
        _controller.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al enviar el comentario')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Comentarios',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Escribe tu comentario...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: enviarComentario,
              child: const Text('Comentar'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: comentarios.map((c) => Text('- $c')).toList(),
        ),
      ],
    );
  }
}
