import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:testudines_solfago/components/my_game.dart';
import 'package:testudines_solfago/components/turtle_component.dart';

class SunComponent extends SpriteComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  @override
  FutureOr<void> onLoad() {
    size = Vector2(64, 64);
    sprite = Sprite(Flame.images.fromCache('sun.png'));
    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is TurtleComponent) {
      game.sunCount -= 1;
      removeFromParent();
    }
  }
}
