import 'package:flame/game.dart';
import 'package:flappy_bird/internal/application.dart';
import 'package:flappy_bird/presentation/home.dart';
import 'package:flutter/material.dart';
void main() {
  final game = GameApp();
  runApp(
    GameWidget(
      game: game,
      overlayBuilderMap: {
        'Конец игры': (context, _) => EndPage(game: game),
      },
    ),
  );
}