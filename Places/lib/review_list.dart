import 'package:flutter/material.dart';
import 'package:places/review.dart';

class ReviewList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final reviewList = Column(
      children: <Widget>[
        Review("assets/images/swi1.jpg","Beth Cast","1 reviews - 3 photos",3, "Muy buen lugar."),
        Review("assets/images/mujer2.jpeg","Elain Michlova","2 reviews - 2 photos",5, "Maravilloso."),
        Review("assets/images/mujer3.jpeg","Alejandra Ivannova","7 reviews - 1 photos",4, "Muy buen lugar."),
        Review("assets/images/mujer4.jpeg","Khatrin Yubero","1 reviews - 3 photos",3, "Muy buen lugar."),
        Review("assets/images/mujer5.jpeg","Revca Petersburgil","9 reviews - 1 photos",1, "Muy buen lugar.")
      ],
    );

    return reviewList;
  }

}