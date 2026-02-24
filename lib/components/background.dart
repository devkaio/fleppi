import 'dart:ui';

import 'package:flame/components.dart';

import '../game/fleppi_game.dart';

/// Fundo do jogo. Fica atrás de todos os outros componentes.
class Background extends PositionComponent with HasGameReference<FleppiGame> {
  final Paint _paint = Paint()..color = const Color(0xFF87CEEB);

  // TODO: trocar forma geométrica por sprite (parte 7)

  @override
  Future<void> onLoad() async {
    await super.onLoad();
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
  void render(Canvas canvas) => canvas.drawRect(size.toRect(), _paint);
}
