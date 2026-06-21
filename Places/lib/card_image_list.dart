import 'package:flutter/material.dart';
import 'card_image.dart';

class CardImageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // cardImageList
    final cardImageList = Container(
      height: 330,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CardImage("assets/images/lugar0.jpg", idPersona: 1, idFoto: 100),
          CardImage("assets/images/lugar1.jpg", idPersona: 1, idFoto: 101),
          CardImage("assets/images/lugar2.jpg", idPersona: 1, idFoto: 102),
          CardImage("assets/images/lugar3.jpg", idPersona: 1, idFoto: 103),
          CardImage("assets/images/lugar4.jpg", idPersona: 1, idFoto: 104),
          CardImage("assets/images/lugar5.jpg", idPersona: 1, idFoto: 105),
        ],
      ),
    );

    return cardImageList;
  }
}
