import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';

import '../game/fleppi_game.dart';

/// Personagem principal controlado pelo jogador.
class Bird extends PositionComponent with HasGameReference<FleppiGame> {
  final Paint _paint = Paint()..color = const Color(0xFFFFD54F);
  final Vector2 _basePosition = Vector2.zero();
  double _time = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;
    size = Vector2(40, 30);
    _basePosition
      ..x = game.size.x * 0.3
      ..y = game.size.y * 0.5;
    position = _basePosition.clone();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _basePosition
      ..x = size.x * 0.3
      ..y = size.y * 0.5;
    position = _basePosition.clone();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _time += dt;
    position.y = _basePosition.y + sin(_time * 2) * 4;
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
