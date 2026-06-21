import 'package:flutter/material.dart';
import 'package:places/gradient_back.dart';
import 'package:places/review.dart';
import 'package:places/review_list.dart';
import 'card_image.dart';
import 'description_pleace.dart';
import 'home_app_bar.dart';

class MyHome extends StatelessWidget {
  MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    final descriptionPlace = Container(
      margin: EdgeInsets.only(
        top: 300,
        left: 30,
        right: 30,
      ),
      child: DescriptionPlace(
        "Uyuni",
        4,
        "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el siglo XVI,",
      ),
    );

    final reviewList = Container(
      margin: EdgeInsets.only(
        top: 20,
        left: 30,
        right: 30,
      ),

      child: ReviewList()
    );

    //ListView
    final listView = ListView(
      children: <Widget>[
        descriptionPlace,
        reviewList
      ],
    );

    return Scaffold(

      body: Stack(
        children: <Widget>[
          listView,
          HomeAppBar("Popular")
        ],
      ),
    );
  }
}



