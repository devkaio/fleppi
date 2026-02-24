import 'package:flame/events.dart';
import 'package:flame/game.dart';

import '../components/background.dart';
import '../components/bird.dart';
import '../components/ground.dart';
import '../components/pipe_group.dart';

enum GameStatus { ready, playing, gameOver, won }

class FleppiGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  final double gravity = 900;
  final double jumpImpulse = -320;
  final double groundHeight = 80;
  final double pipeGap = 140;
  final double pipeSpeed = 120;
  final double pipeWidth = 60;
  final double pipeSpawnXOffset = 120;
  final double pipeTopRatio = 0.35;
  final double birdStartXFactor = 0.3;
  final double birdStartYFactor = 0.5;
  final Vector2 birdSize = Vector2(40, 30);

  GameStatus status = GameStatus.ready;
  int score = 0;

  late final Background background;
  late final Ground ground;
  late final Bird bird;
  late final PipeGroup pipeGroup;
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    background = Background();
    ground = Ground(height: groundHeight);
    bird = Bird();
    pipeGroup = PipeGroup(
      gap: pipeGap,
      speed: pipeSpeed,
      groundHeight: groundHeight,
      width: pipeWidth,
      spawnXOffset: pipeSpawnXOffset,
      topRatio: pipeTopRatio,
    );

    addAll([
      background,
      ground,
      bird,
      pipeGroup,
    ]);
  }

  bool get isPlaying => status == GameStatus.playing;

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (status == GameStatus.ready) {
      status = GameStatus.playing;
      bird.flap();
      return;
    }
    if (status == GameStatus.gameOver || status == GameStatus.won) {
      resetGame();
      status = GameStatus.playing;
      bird.flap();
      return;
    }
    bird.flap();
  }

  void incrementScore() {
    if (!isPlaying) return;
    score += 1;
  }

  void gameOver() {
    if (status == GameStatus.gameOver) return;
    status = GameStatus.gameOver;
  }

  void gameWon() {
    status = GameStatus.won;
  }

  void resetGame() {
    score = 0;
    status = GameStatus.ready;
    bird.reset();
    pipeGroup.reset();
  }
}
