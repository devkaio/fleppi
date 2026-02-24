import 'package:flame/components.dart';

/// Cano individual (topo ou base) dentro do PipeGroup.
class Pipe extends PositionComponent {
	Pipe({required this.isTop});

	final bool isTop;
}
