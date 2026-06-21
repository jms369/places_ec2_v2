import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'utils/api_config.dart';

class ComentariosGlobal extends StatefulWidget {
  final int idPersona; // id del usuario logueado
  const ComentariosGlobal({Key? key, required this.idPersona}) : super(key: key);

  @override
  State<ComentariosGlobal> createState() => _ComentariosGlobalState();
}

class _ComentariosGlobalState extends State<ComentariosGlobal> {
  final TextEditingController _controller = TextEditingController();
  List<String> comentarios = [];

  Future<void> enviarComentario() async {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;

    final url = Uri.parse('${getBaseUrl()}/api/comentarios');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id_personas': widget.idPersona,
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
