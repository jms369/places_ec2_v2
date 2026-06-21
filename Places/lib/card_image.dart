import 'package:flutter/material.dart';
import 'fab_green.dart';

class CardImage extends StatelessWidget {
  final String path;
  final int idPersona; // id del usuario
  final int idFoto;    // id simulado de la foto

  CardImage(this.path, {required this.idPersona, required this.idFoto});

  @override
  Widget build(BuildContext context) {
    // card
    final card = Padding(
      padding: EdgeInsets.only(top: 100, right: 15, bottom: 30),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(path),
            fit: BoxFit.cover,
          ),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black45,
              blurRadius: 15,
              offset: Offset(0, 10),
            )
          ],
        ),
      ),
    );

    // stack con el corazón
    final cardImage = Stack(
      alignment: Alignment(0.7, 0.95),
      children: <Widget>[
        card,
        FabGreen(idPersona: idPersona, idFoto: idFoto),
      ],
    );

    return cardImage;
  }
}
