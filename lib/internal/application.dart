import 'package:flappy_bird/presentation/home.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Flappy Bird",
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: Home(),
    );
  }
}