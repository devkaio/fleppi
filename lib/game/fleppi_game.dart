import 'package:flame/game.dart';

import '../components/background.dart';
import '../components/bird.dart';
import '../components/ground.dart';
import '../components/pipe_group.dart';

class FleppiGame extends FlameGame {
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
// TODO: integrar game loop e atualizar componentes com formas (parte 4)
