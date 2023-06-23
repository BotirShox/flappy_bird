import 'package:flappy_bird/internal/application.dart';
import 'package:flutter/material.dart';

class EndPage extends StatelessWidget {
  final GameApp game;

  const EndPage({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Конец Игры',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                game.restartGame();
                game.overlays.remove('Возобновить');
              },
              child: Text(
                'Возобновить',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}