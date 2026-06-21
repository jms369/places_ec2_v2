import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FabGreen extends StatefulWidget {
  final int idPersona; // id del usuario
  final int idFoto;    // id de la foto (simulado)

  FabGreen({required this.idPersona, required this.idFoto});

  @override
  State<StatefulWidget> createState() {
    return _FabGreen();
  }
}

class _FabGreen extends State<FabGreen> {
  var _fabIcon = Icons.favorite_border;

  void onPressedFav() async {
    setState(() {
      if (_fabIcon == Icons.favorite_border) {
        _fabIcon = Icons.favorite;
      } else {
        _fabIcon = Icons.favorite_border;
      }
    });

    final estado = _fabIcon == Icons.favorite ? 'LLENO' : 'VACIO';

    final url = Uri.parse('http://TU_BACKEND/api/likes');
    await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id_persona': widget.idPersona,
        'id_foto': widget.idFoto,
        'estado': estado,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color(0xFF16db58),
      mini: true,
      tooltip: "Like",
      child: Icon(_fabIcon),
      onPressed: onPressedFav,
    );
  }
}
