import 'package:flame/game.dart';

import '../components/background.dart';
import '../components/bird.dart';
import '../components/ground.dart';
import '../components/pipe_group.dart';

class FleppiGame extends FlameGame {
	// TODO: definir propriedades do mundo (gravidade, velocidade, etc.) (parte 5)
	@override
	Future<void> onLoad() async {
		await super.onLoad();

		addAll([
			Background(),
			Ground(),
			Bird(),
			PipeGroup(),
		]);
	}
}
