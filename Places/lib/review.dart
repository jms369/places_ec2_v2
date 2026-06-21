import 'package:flutter/material.dart';

class Review extends StatelessWidget{

  //variables
  String pathFoto;
  String textoNombreUsuario;
  String textoResumenUsuario;
  int cantidadEstrellas;
  String textoComentario;

  //metodo constructor
  Review(this.pathFoto, this.textoNombreUsuario, this.textoResumenUsuario, this.cantidadEstrellas, this.textoComentario);

  @override
  Widget build(BuildContext context) {
    //foto
    final foto = Container(
      margin: EdgeInsets.only(
        top: 10,
        right: 10
      ),
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        shape:BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(
           pathFoto
      ),
          fit: BoxFit.cover
      )
      ),
    );
    //nombre del usuario
    final nombreUsuario = Container(
      child: Text(
        textoNombreUsuario,
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 18
        ),
      ),
    );
    //resumen usuario
    final resumenUsuario = Container(
      margin: EdgeInsets.only(
        right: 10
      ),
      child: Text(
        textoResumenUsuario,
        style: TextStyle(
          fontFamily: "Lato",
          color: Colors.black54
      ),
      ),
    );

    //estrella
    final estrella = Container(
    margin: EdgeInsets.only(right: 1),
    child: Icon(
    Icons.star,
    color: Colors.amber,
      size: 18,
    ),
    );

    //estrella borde
    final estrellaBorde = Container(
    margin: EdgeInsets.only(right: 1),
    child: Icon(
    Icons.star_border,
    color: Colors.black54,
      size: 18,
    ),
    );

    // Lista de estrellas
    final List<Widget> estrellas = [];
    for (int i = 0; i < 5; i++) {
    if (i < cantidadEstrellas) {
    estrellas.add(estrella);
    } else {
    estrellas.add(estrellaBorde);
    }
    }

    final filaEstrellas = Row(

    children: estrellas,
    );

    //fila resumen
    final filaResumen = Row(
      children: <Widget>[
        resumenUsuario,
        filaEstrellas
      ],
    );

    //comentario
    final comentario = Container(
      child: Text(
        textoComentario,
        style: TextStyle(
          fontFamily: "Lato",
        ),
      ),
    );

    //columna review
    final columnReview = Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        nombreUsuario,
        filaResumen,
        comentario
      ],
    );

    //review
    final review = Row(
      children: <Widget>[
        foto,
        columnReview
      ],
    );

    return review;
  }

}