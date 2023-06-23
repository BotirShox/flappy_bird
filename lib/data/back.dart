import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/internal/application.dart';

class Background extends SpriteComponent with HasGameRef<GameApp> {
  Background();

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load('back.png');
    size = gameRef.size;
    sprite = Sprite(image);
  }
}