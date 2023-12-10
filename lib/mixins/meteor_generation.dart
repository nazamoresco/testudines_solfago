import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame/timer.dart';
import 'package:testudines_solfago/components/meteor_component.dart';
import 'package:testudines_solfago/mixins/canvas_contained.dart';

mixin MeteorGeneration on FlameGame, CanvasContained {
  int meteorCount = 0;

  late Timer meteorGeneration;

  void startMeteorGeneration() {
    meteorGeneration = Timer(0.5, onTick: runMeteorGeneration, repeat: true);
  }

  void runMeteorGeneration() {
    final rand = Random();
    // ignore: lines_longer_than_80_chars
    final shouldCreateSun = meteorCount <= 5 + game.turtleComponent.eatenSunsCount;
    if (shouldCreateSun) {
      meteorCount += 1;
      world.add(
        MeteorComponent()
          ..position = positionOnCanvas(
            Vector2(
              0,
              // rand.nextInt(canvasSize.x.toInt()).toDouble(),
              rand.nextInt(canvasSize.y.toInt()).toDouble(),
            ),
          ),
      );
    }
  }

  void updateMeteorGeneration(double dt) {
    meteorGeneration.update(dt);
  }
}
