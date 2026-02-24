import 'dart:ui';

import 'package:flame/components.dart';

import '../game/fleppi_game.dart';

/// Personagem principal controlado pelo jogador.
class Bird extends PositionComponent with HasGameReference<FleppiGame> {
  // TODO: adicionar hitbox e lógica de colisão (parte 6)
  final Paint _paint = Paint()..color = const Color(0xFFFFD54F);
  final Vector2 _basePosition = Vector2.zero();
  double _velocityY = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;
    size = game.birdSize.clone();
    _basePosition
      ..x = game.size.x * game.birdStartXFactor
      ..y = game.size.y * game.birdStartYFactor;
    position = _basePosition.clone();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _basePosition
      ..x = size.x * game.birdStartXFactor
      ..y = size.y * game.birdStartYFactor;
    position = _basePosition.clone();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _velocityY += game.gravity * dt;
    position.y += _velocityY * dt;

    final groundTop = game.size.y - game.groundHeight;
    final maxY = groundTop - size.y / 2;
    if (position.y > maxY) {
      position.y = maxY;
      _velocityY = 0;
    }
  }

  @override
  void render(Canvas canvas) {
    final rect = size.toRect();
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(6)),
      _paint,
    );
  }
}
