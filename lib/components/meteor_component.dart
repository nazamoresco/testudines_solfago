import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:testudines_solfago/components/meteor_trail_component.dart';
import 'package:testudines_solfago/components/my_game.dart';

class MeteorComponent extends PositionComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  @override
  FutureOr<void> onLoad() {
    anchor = Anchor.center;
    size = Vector2(10, 10);
    add(RectangleHitbox());

    final direction = position - oppositePosition;
    add(
      MeteorTrailComponent(from: Colors.black, to: Colors.white)
        ..position = size / 2
        ..angle = atan2(direction.y, direction.x) + pi * 4 / 4,
    );

    add(
      MoveEffect.to(
        oppositePosition,
        EffectController(
          duration: 6,
        ),
        onComplete: () {
          game.meteorCount -= 1;
          removeFromParent();
        },
      ),
    );

    return super.onLoad();
  }

  Vector2 get oppositePosition {
    return Vector2(
      game.canvasSize.x - position.x,
      game.canvasSize.y - position.y,
    );
  }
}
