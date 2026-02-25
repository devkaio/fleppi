import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../game/fleppi_game.dart';

/// Personagem principal controlado pelo jogador.
class Bird extends SpriteComponent
    with HasGameReference<FleppiGame>, CollisionCallbacks {
  // TODO: adicionar rotação conforme sobe/desce (parte 9)
  // TODO: adicionar animação de queda ao game over (parte 9)
  final Vector2 _basePosition = Vector2.zero();
  double _velocityY = 0;
  late final CircleHitbox _hitbox;

  // @override
  // bool get debugMode => true;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;
    size = game.birdSize.clone();
    sprite = await Sprite.load('bird.png');
    _hitbox = CircleHitbox(isSolid: true);
    add(_hitbox);
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
    if (!game.isPlaying) {
      position = _basePosition.clone();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!game.isPlaying) return;
    _velocityY += game.gravity * dt;
    position.y += _velocityY * dt;

    final groundTop = game.size.y - game.groundHeight;
    final maxY = groundTop - size.y / 2;
    if (position.y > maxY) {
      position.y = maxY;
      _velocityY = 0;
      game.gameOver();
    }
  }

  void flap() {
    if (!game.isPlaying && game.status != GameStatus.ready) return;
    _velocityY = game.jumpImpulse;
    game.playFly();
  }

  void reset() {
    _velocityY = 0;
    position = _basePosition.clone();
  }

  double get hitboxRadius => _hitbox.radius;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    game.gameOver();
  }
}
