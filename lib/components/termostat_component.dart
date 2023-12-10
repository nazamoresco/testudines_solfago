import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:testudines_solfago/components/my_game.dart';

class TermostatComponent extends SpriteComponent with HasGameRef<MyGame> {
  late final RectangleComponent indicatorComponent;

  @override
  FutureOr<void> onLoad() {
    final image = Flame.images.fromCache('termostat.png');

    final desiredHeight = game.canvasSize.y * 0.4;
    size = Vector2(
      desiredHeight * image.size.x / image.size.y,
      desiredHeight,
    );

    position = Vector2(
      0,
      game.canvasSize.y * 0.6,
    );

    sprite = Sprite(image);

    indicatorComponent = RectangleComponent(
      position: Vector2(size.x * 0.51, size.y * 0.83),
      anchor: Anchor.bottomCenter,
      size: Vector2(
        size.x * 0.05,
        game.turtleComponent.temperature * size.y * 0.0038,
      ),
      paint: Paint()..color = Colors.black.withOpacity(0.9),
    );

    add(indicatorComponent);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    indicatorComponent.size.y =
        game.turtleComponent.temperature * size.y * 0.0038;
    super.update(dt);
  }
}
