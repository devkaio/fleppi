import 'dart:ui';

import 'package:flame/components.dart';

import '../game/fleppi_game.dart';

/// Fundo do jogo. Fica atrás de todos os outros componentes.
class Background extends SpriteComponent with HasGameReference<FleppiGame> {
  Background({this.scrollSpeed = 20});

  final double scrollSpeed;
  double _scrollX = 0;
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load('background.png');
    position = Vector2.zero();
    size = game.size;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position = Vector2.zero();
    this.size = size;
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
