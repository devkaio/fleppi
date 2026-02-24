import 'package:flame/components.dart';

import '../game/fleppi_game.dart';
import 'pipe.dart';

/// Grupo de canos gerados em conjunto (topo e base).
class PipeGroup extends PositionComponent with HasGameReference<FleppiGame> {
  PipeGroup({this.gap = 140, this.speed = 100, this.groundHeight = 80});

  final Pipe top = Pipe(isTop: true);
  final Pipe bottom = Pipe(isTop: false);
  final double gap;
  final double speed;
  final double groundHeight;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.topLeft;
    _positionForSize(game.size);
    addAll([top, bottom]);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _positionForSize(size);
  }

  void _positionForSize(Vector2 gameSize) {
    final availableHeight = gameSize.y - groundHeight;
    final topHeight = availableHeight * 0.35;
    final bottomHeight = availableHeight - topHeight - gap;

    size = Vector2(60, availableHeight);
    position = Vector2(gameSize.x + 120, 0);

    top
      ..position = Vector2.zero()
      ..size = Vector2(size.x, topHeight);
    bottom
      ..position = Vector2(0, topHeight + gap)
      ..size = Vector2(size.x, bottomHeight);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= speed * dt;
    if (position.x + size.x < 0) {
      position.x = game.size.x + 120;
    }
  }
}
