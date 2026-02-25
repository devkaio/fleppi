import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/fleppi_game.dart';

void main() => runApp(
  GameWidget<FleppiGame>(
    game: FleppiGame(),
    overlayBuilderMap: {
      'game-ready': (context, game) => GameReadyOverlay(
        onTap: () {
          game.overlays.remove('game-ready');
          game.status = GameStatus.playing;
          game.bird.flap();
        },
      ),
      'game-over': (context, game) => GameOverOverlay(
        score: game.score,
        onRestart: () {
          game.overlays.remove('game-over');
          game.resetGame();
          game.status = GameStatus.playing;
          game.resumeEngine();
        },
      ),
      'you-win': (context, game) => YouWinOverlay(
        score: game.score,
        onRestart: () {
          game.overlays.remove('you-win');
          game.resetGame();
          game.status = GameStatus.playing;
          game.resumeEngine();
        },
      ),
    },
  ),
);

class GameReadyOverlay extends StatelessWidget {
  final VoidCallback onTap;

  const GameReadyOverlay({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 48,
              vertical: 16,
            ),
            backgroundColor: Colors.white,
          ),
          child: const Text(
            'Toque para Começar',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class GameOverOverlay extends StatelessWidget {
  final int score;
  final VoidCallback onRestart;

  const GameOverOverlay({
    required this.score,
    required this.onRestart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.7),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Fim de Jogo',
              style: TextStyle(
                fontSize: 48,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Pontuação: $score',
              style: const TextStyle(
                fontSize: 32,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: onRestart,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 16,
                ),
                backgroundColor: Colors.white,
              ),
              child: const Text(
                'Recomeçar',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YouWinOverlay extends StatelessWidget {
  final int score;
  final VoidCallback onRestart;

  const YouWinOverlay({
    required this.score,
    required this.onRestart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.7),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Você Venceu!',
              style: TextStyle(
                fontSize: 48,
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Score: $score',
              style: const TextStyle(
                fontSize: 32,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: onRestart,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 16,
                ),
                backgroundColor: Colors.greenAccent,
              ),
              child: const Text(
                'Jogar Novamente',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
