import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class EggsComponents extends PositionComponent {
  final int eggCount;

  EggsComponents(this.eggCount);

  @override
  FutureOr<void> onLoad() {
    add(
      ParticleSystemComponent(particle: fireworkParticle())
        ..anchor = Anchor.center
        ..position = size / 2,
    );
    return super.onLoad();
  }

  /// Returns a random element from a given list
  T randomElement<T>(List<T> list) {
    return list[Random().nextInt(list.length)];
  }

  final Tween<double> noise = Tween(begin: -50, end: 50);

  Vector2 generateOffset(double minDistance) {
    final random = Random();
    Vector2 offset;

    do {
      offset = Vector2(
        noise.transform(random.nextDouble()),
        noise.transform(random.nextDouble()),
      );
    } while (offset.length <
        minDistance); // Check if the offset is less than the minimum distance

    return offset;
  }

  Particle fireworkParticle() {
    return Particle.generate(
      lifespan: 10000,
      count: eggCount,
      generator: (i) {
        return TranslatedParticle(
          offset: generateOffset(35),
          child: ImageParticle(
            image: Flame.images.fromCache('egg.png'),
            size: Vector2(10, 10),
          ),
        );
      },
    );
  }
}
