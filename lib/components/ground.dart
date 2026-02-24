import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../game/fleppi_game.dart';

/// Faixa do chão para referência visual e colisão.
class Ground extends PositionComponent with HasGameReference<FleppiGame> {
  Ground({this.height = 80});

  @override
  final double height;
  final Paint _paint = Paint()..color = const Color(0xFF8D6E63);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
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
  void render(Canvas canvas) => canvas.drawRect(size.toRect(), _paint);
}
