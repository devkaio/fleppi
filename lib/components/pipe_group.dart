import 'package:flame/components.dart';

import 'pipe.dart';

/// Grupo de canos gerados em conjunto (topo e base).
class PipeGroup extends PositionComponent {
	final Pipe top = Pipe(isTop: true);
	final Pipe bottom = Pipe(isTop: false);

	@override
	Future<void> onLoad() async {
		await super.onLoad();
		addAll([top, bottom]);
	}
}
