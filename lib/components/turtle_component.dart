import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:testudines_solfago/components/eggs_components.dart';
import 'package:testudines_solfago/components/explosion_component.dart';
import 'package:testudines_solfago/components/meteor_component.dart';
import 'package:testudines_solfago/components/my_game.dart';
import 'package:testudines_solfago/components/sun_component.dart';
import 'package:testudines_solfago/enums/endings.dart';
import 'package:testudines_solfago/enums/overlays.dart';
import 'package:testudines_solfago/mixins/canvas_contained.dart';

class TurtleComponent extends SpriteAnimationComponent
    with HasGameRef<MyGame>, CollisionCallbacks, CanvasContained {
  double temperature = 60;

  double speed = 0;

  Vector2? targetPosition;

  late Timer temperatureDecay;

  int eatenSunsCount = 0;

  TurtleComponent() : super(anchor: Anchor.center, size: Vector2.all(88)) {
    temperatureDecay = Timer(
      1,
      onTick: () async {
        if (game.gameEnd != null) {
          return;
        }

        temperature -= 5;

        if (temperature == 0) {
          tooCold();
        } else if (temperature > 110) {
          await tooHot();
        } else if (temperature < 40) {
          FlameAudio.play('wind.mp3');
          game.overlays.add(Overlays.freezing.toString());
        } else if (temperature > 90) {
          FlameAudio.play('burning.wav');
          game.overlays.add(Overlays.burning.toString());
        } else {
          game.overlays.removeAll(
            [Overlays.freezing.toString(), Overlays.burning.toString()],
          );
        }
      },
      repeat: true,
    );
  }

  void tooCold() {
    game.superColdEnding();
    direction *= 0.1;
  }

  Future<void> tooHot() async {
    animation = null;
    direction *= 0;

    add(
      ExplosionComponent()
        ..anchor = Anchor.center
        ..position = size / 2,
    );

    game.superHotEnding();
    await Future.delayed(const Duration(seconds: 1));
    angle = 0;
    animation = SpriteAnimation.spriteList(
      [Sprite(Flame.images.fromCache('sun.png'))],
      stepTime: 1,
    );
  }

  @override
  FutureOr<void> onLoad() {
    position = game.canvasSize / 2;

    animation = SpriteSheet(
      image: Flame.images.fromCache('turtle-animation.png'),
      srcSize: Vector2(512, 512),
    ).createAnimation(row: 0, stepTime: 0.1, to: 12);

    add(
      RectangleHitbox(
        size: size / 2,
        position: size / 2,
        anchor: Anchor.center,
      ),
    );
    return super.onLoad();
  }

  SpriteAnimation get stillShellAnimation => SpriteAnimation.spriteList(
        [Sprite(Flame.images.fromCache('turtle-shell.png'))],
        stepTime: 1,
      );

  void spawnEggs() {
    position = game.canvasSize / 2;
    direction *= 0;
    add(
      EggsComponents(eatenSunsCount)
        ..anchor = Anchor.center
        ..position = size / 2,
    );
    animation = stillShellAnimation;
  }

  void forward({required bool isPressed}) {
    speed = isPressed ? maxSpeed : 0;
  }

  Vector2 direction = Vector2(0, 0);
  double moveSpeed = 100;
  static const double maxSpeed = 200;
  Vector2 velocity = Vector2.zero();

  void pointForward() => direction.y = max(direction.y - moveSpeed, -maxSpeed);
  void pointBack() => direction.y = min(direction.y + moveSpeed, maxSpeed);
  void pointLeft() => direction.x = max(direction.x - moveSpeed, -maxSpeed);
  void pointRight() => direction.x = min(direction.x + moveSpeed, maxSpeed);
  void moveTo(Vector2 target) {
    direction = target - position;
    direction.x = min(direction.x, maxSpeed);
    direction.x = max(direction.x, -maxSpeed);
    direction.y = min(direction.y, maxSpeed);
    direction.y = max(direction.y, -maxSpeed);
  }

  @override
  void update(double dt) {
    position = positionOnCanvas(position + direction * dt);

    if (game.gameEnd != Ending.superHot) {
      angle = atan2(direction.y, direction.x) + pi / 2;
    }

    temperatureDecay.update(dt);
    super.update(dt);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (game.gameEnd != null) {
      return;
    }

    if (other is SunComponent) {
      FlameAudio.play('crecendo.wav');
      temperature += 15;
      eatenSunsCount += 1;
    } else if (other is MeteorComponent) {
      animation = stillShellAnimation;
      direction *= 0.1;
      game.meteorCrashEnding();
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}
