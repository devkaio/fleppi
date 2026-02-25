import 'package:flame/components.dart';

import '../game/fleppi_game.dart';
import 'pipe.dart';

/// Grupo de canos gerados em conjunto (topo e base).
class PipeGroup extends PositionComponent with HasGameReference<FleppiGame> {
  PipeGroup({
    required this.gap,
    required this.speed,
    required this.groundHeight,
    required this.width,
    required this.spawnXOffset,
    required this.topRatio,
  });

  final Pipe top = Pipe(isTop: true);
  final Pipe bottom = Pipe(isTop: false);
  final double gap;
  final double speed;
  final double groundHeight;
  @override
  final double width;
  final double spawnXOffset;
  final double topRatio;
  bool _scored = false;
  double _topHeight = 0;

  // @override
  // bool get debugMode => true;

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
    final topHeight = availableHeight * topRatio;
    final bottomHeight = availableHeight - topHeight - gap;
    _topHeight = topHeight;

    size = Vector2(width, availableHeight);
    position = Vector2(gameSize.x + spawnXOffset, 0);

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
    if (!game.isPlaying) return;
    position.x -= speed * dt;
    _checkBirdVerticalLimit();
    if (!_scored && position.x + size.x < game.bird.position.x) {
      _scored = true;
      game.incrementScore();
    }
    if (position.x + size.x < 0) {
      position.x = game.size.x + spawnXOffset;
      _scored = false;
    }
  }

  void reset() {
    _scored = false;
    _positionForSize(game.size);
  }

  void _checkBirdVerticalLimit() {
    final bird = game.bird;
    final radius = bird.hitboxRadius;
    final birdLeft = bird.position.x - radius;
    final birdRight = bird.position.x + radius;
    final pipeLeft = position.x;
    final pipeRight = position.x + size.x;
    final overlapsX = birdRight > pipeLeft && birdLeft < pipeRight;
    if (!overlapsX) return;

    final birdTop = bird.position.y - radius;
    final birdBottom = bird.position.y + radius;
    final gapTop = _topHeight;
    final gapBottom = _topHeight + gap;
    if (birdTop < gapTop || birdBottom > gapBottom) {
      game.gameOver();
    }
  }
}
