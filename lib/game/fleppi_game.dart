import 'package:flame/components.dart';
import 'package:flame/game.dart';

import '../components/background.dart';
import '../components/bird.dart';
import '../components/ground.dart';
import '../components/pipe_group.dart';

class FleppiGame extends FlameGame {
	// TODO: implementar onTapDown (parte 6)
	// TODO: implementar incrementScore (parte 6)
	// TODO: implementar gameOver (parte 6)
	// TODO: implementar resetGame (parte 6)
	// TODO: implementar gameWon (parte 6)
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
	@override
	Future<void> onLoad() async {
		await super.onLoad();

		addAll([
			Background(),
			Ground(height: groundHeight),
			Bird(),
			PipeGroup(
				gap: pipeGap,
				speed: pipeSpeed,
				groundHeight: groundHeight,
				width: pipeWidth,
				spawnXOffset: pipeSpawnXOffset,
				topRatio: pipeTopRatio,
			),
		]);
	}
}
