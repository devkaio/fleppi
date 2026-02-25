import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/text.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

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
  final double backgroundScrollSpeed = 20;
  final double groundScrollSpeed = 120;
  final double pipeWidth = 60;
  final double pipeSpawnXOffset = 120;
  final double pipeTopRatio = 0.35;
  final double birdStartXFactor = 0.3;
  final double birdStartYFactor = 0.5;
  final Vector2 birdSize = Vector2(71, 50);

  GameStatus status = GameStatus.ready;
  int score = 0;

  late final Background background;
  late final Ground ground;
  late final Bird bird;
  late final PipeGroup pipeGroup;
  late final TextComponent scoreText;
  late final AudioPool flyPool;
  late final AudioPool scorePool;
  late final AudioPool crashPool;
  bool _audioReady = false;
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await FlameAudio.audioCache.loadAll([
      'fly.wav',
      'score.wav',
      'crash.wav',
    ]);
    flyPool = await FlameAudio.createPool(
      'fly.wav',
      maxPlayers: 2,
    );
    scorePool = await FlameAudio.createPool(
      'score.wav',
      maxPlayers: 2,
    );
    crashPool = await FlameAudio.createPool(
      'crash.wav',
      maxPlayers: 1,
    );
    _audioReady = true;

    background = Background(scrollSpeed: backgroundScrollSpeed);
    ground = Ground(height: groundHeight, scrollSpeed: groundScrollSpeed);
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

    scoreText = TextComponent(
      text: '0',
      position: Vector2(12, 12),
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(scoreText);
  }

  @override
  void onRemove() {
    flyPool.dispose();
    scorePool.dispose();
    crashPool.dispose();
    super.onRemove();
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
    scoreText.text = score.toString();
    playScore();
  }

  void gameOver() {
    if (status == GameStatus.gameOver) return;
    status = GameStatus.gameOver;
    playCrash();
  }

  void gameWon() {
    status = GameStatus.won;
  }

  void resetGame() {
    score = 0;
    status = GameStatus.ready;
    bird.reset();
    pipeGroup.reset();
    scoreText.text = '0';
  }

  void playFly() {
    if (!_audioReady) return;
    flyPool.start();
  }

  void playScore() {
    if (!_audioReady) return;
    scorePool.start();
  }

  void playCrash() {
    if (!_audioReady) return;
    crashPool.start();
  }
}
