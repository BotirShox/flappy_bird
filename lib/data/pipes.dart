import 'dart:io';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird/internal/application.dart';

class PipeS extends PositionComponent with HasGameRef<GameApp> {
  PipeS();

  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;
    final heightMinusGround = gameRef.size.y - 110;

    final spacing = 90 + _random.nextDouble() * (heightMinusGround / 4);
    final centerY =
        spacing + _random.nextDouble() * (heightMinusGround - spacing);
    addAll([
      OnePipe(pipePosition: PipePosition.top, height: centerY - spacing / 2),
      OnePipe(
          pipePosition: PipePosition.bottom,
          height: heightMinusGround - (centerY + spacing / 2)),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= gameRef.speed * dt;
    if (position.x < -50) {
      removeFromParent();
    }
  }
}
class OnePipe extends SpriteComponent with HasGameRef<GameApp> {
  OnePipe({required PipePosition pipePosition, required double height})
      : _pipePosition = pipePosition,
        _height = height;

  final PipePosition _pipePosition;
  final double _height;

  @override
  Future<void> onLoad() async {
    final pipe = await Flame.images.load('pipe.png');
    final pipeRotated = await Flame.images.load('rotated.png');
    size = Vector2(50, _height);
    switch (_pipePosition) {
      case PipePosition.top:
        position.y = 0;
        sprite = Sprite(pipeRotated);
        break;
      case PipePosition.bottom:
        position.y = gameRef.size.y - size.y - 110;
        sprite = Sprite(pipe);
        break;
    }

    add(RectangleHitbox());
  }
}

enum PipePosition { top, bottom }
