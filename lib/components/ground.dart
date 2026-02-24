import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../game/fleppi_game.dart';

/// Faixa do chão para referência visual e colisão.
class Ground extends SpriteComponent with HasGameReference<FleppiGame> {
  // TODO: adicionar efeito parallax (parte 8)
  Ground({this.height = 80});

  @override
  final double height;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load('ground.png');
    _positionForSize(game.size);
    add(RectangleHitbox());
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _positionForSize(size);
  }

  void _positionForSize(Vector2 gameSize) {
    position = Vector2(0, gameSize.y - height);
    size = Vector2(gameSize.x, height);
  }
}
