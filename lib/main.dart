import 'package:flutter/material.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/loading.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: "/", //hierarquicamente mais alto que o route de baixo
      //home: Home(),
      routes: {
        "/": (context) => Loading(), // a primeira pagina a aparecer. É Escolinha o loading screen porque a app precisade carregar os dados antes de abrir
        "/home": (context) => Home(),
        "/location": (context) => ChooseLocation()
      },
    )
  );
}

