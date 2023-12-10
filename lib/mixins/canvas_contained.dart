import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:testudines_solfago/components/my_game.dart';

mixin CanvasContained on HasGameRef<MyGame> {
  Vector2 positionOnCanvas(
    Vector2 position, {
    EdgeInsets? padding,
  }) {
    padding = padding ?? EdgeInsets.zero;

    position.x = max(
      min(
        position.x,
        game.canvasSize.x - padding.right,
      ),
      0 + padding.left,
    );

    position.y = max(
      min(
        position.y,
        game.canvasSize.y - padding.bottom,
      ),
      0 + padding.top,
    );

    return position;
  }
}
