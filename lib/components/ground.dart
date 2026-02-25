import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../game/fleppi_game.dart';

/// Faixa do chão para referência visual e colisão.
class Ground extends SpriteComponent with HasGameReference<FleppiGame> {
  Ground({this.height = 80, this.scrollSpeed = 120});

  @override
  final double height;
  final double scrollSpeed;
  double _scrollX = 0;

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

  @override
  void update(double dt) {
    super.update(dt);
    if (!game.isPlaying) return;
    if (size.x <= 0) return;
    _scrollX = (_scrollX + scrollSpeed * dt) % size.x;
  }

  @override
  void render(Canvas canvas) {
    if (sprite == null) return;
    canvas.save();
    canvas.translate(-_scrollX, 0);
    super.render(canvas);
    canvas.translate(size.x, 0);
    super.render(canvas);
    canvas.restore();
  }
}
