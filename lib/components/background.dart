import 'package:flame/components.dart';

import '../game/fleppi_game.dart';

/// Fundo do jogo. Fica atrás de todos os outros componentes.
class Background extends SpriteComponent with HasGameReference<FleppiGame> {
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
}
