import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class MeteorTrailComponent extends PositionComponent {
  final random = Random();
  final Tween<double> horizontalNoise = Tween(begin: -15, end: 0);
  final Tween<double> verticalNoise = Tween(begin: -0.5, end: 0.5); // TODO: Reduced here, check
  final ColorTween colorTween;

  MeteorTrailComponent({
    required Color from,
    required Color to,
  }) : colorTween = ColorTween(begin: from, end: to);

  @override
  void update(double dt) {
    add(
      ParticleSystemComponent(
        particle: Particle.generate(
          count: 40,
          generator: (i) {
            return AcceleratedParticle(
              lifespan: 2,
              speed: Vector2(
                    horizontalNoise.transform(random.nextDouble()),
                    verticalNoise.transform(random.nextDouble()),
                  ) *
                  i.toDouble(),
              child: CircleParticle(
                radius: 2,
                paint: Paint()
                  ..color = colorTween.transform(random.nextDouble())!,
              ),
            );
          },
        ),
      ),
    );
  }
}
