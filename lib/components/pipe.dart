import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

/// Cano individual (topo ou base) dentro do PipeGroup.
class Pipe extends PositionComponent {
  Pipe({required this.isTop});

  final bool isTop;
  final Paint _paint = Paint()..color = const Color(0xFF66BB6A);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }
}
