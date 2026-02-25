import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

/// Cano individual (topo ou base) dentro do PipeGroup.
class Pipe extends SpriteComponent {
  Pipe({required this.isTop});

  final bool isTop;
  
  // @override
  // bool get debugMode => true;
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load(isTop ? 'pipe_top.png' : 'pipe_bottom.png');
    add(RectangleHitbox());
  }
}
