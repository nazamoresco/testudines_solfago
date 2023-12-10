import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

class ExplosionComponent extends PositionComponent {
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

  final Tween<double> noise = Tween(begin: -2, end: 2);

  Particle fireworkParticle() {
    final paints = [
      Colors.grey,
      Colors.black,
      Colors.white,
      const Color(0xFFd3be8a),
    ].map((color) => Paint()..color = color).toList();

    final rnd = Random();

    return Particle.generate(
      lifespan: 3,
      generator: (i) {
        return ComputedParticle(
          renderer: (canvas, particle) {
            final paint = randomElement(paints);
            paint.color = paint.color.withOpacity(1 - particle.progress);
            canvas.drawCircle(
              Offset.zero,
              rnd.nextDouble() * (300 * particle.progress),
              paint,
            );
          },
        );
      },
    );
  }
}
