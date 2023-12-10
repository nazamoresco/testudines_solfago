import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:testudines_solfago/components/sun_component.dart';
import 'package:testudines_solfago/mixins/canvas_contained.dart';

mixin SunGeneration on FlameGame, CanvasContained {
  int sunCount = 0;

  void runSunGeneration() {
    final rand = Random();
    final shouldCreateSun = rand.nextBool() && sunCount <= 5;
    if (shouldCreateSun) {
      sunCount += 1;
      world.add(
        SunComponent()
          ..position = positionOnCanvas(
            Vector2(
              rand.nextInt(canvasSize.x.toInt()).toDouble(),
              rand.nextInt(canvasSize.y.toInt()).toDouble(),
            ),
            padding: EdgeInsets.only(
              top: 64,
              left: 64,
              right: 64,
              bottom: canvasSize.y * 0.25,
            ),
          ),
      );
    }
  }
}
