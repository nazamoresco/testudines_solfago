import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testudines_solfago/components/background_component.dart';
import 'package:testudines_solfago/components/termostat_component.dart';
import 'package:testudines_solfago/components/turtle_component.dart';
import 'package:testudines_solfago/enums/endings.dart';
import 'package:testudines_solfago/enums/overlays.dart';
import 'package:testudines_solfago/enums/text_styles.dart';
import 'package:testudines_solfago/mixins/canvas_contained.dart';
import 'package:testudines_solfago/mixins/meteor_generation.dart';
import 'package:testudines_solfago/mixins/sun_generation.dart';

class MyGame extends FlameGame
    with
        KeyboardEvents,
        HasCollisionDetection,
        HasGameRef<MyGame>,
        CanvasContained,
        SunGeneration,
        MeteorGeneration,
        TapCallbacks {
  late TurtleComponent turtleComponent;

  Ending? gameEnd;

  int targetEggs = 20;

  late TextComponent eggCounterComponent;

  @override
  Future<void> onLoad() async {
    await FlameAudio.audioCache.loadAll([
      'tango.mp3',
      'wind.mp3',
      'gong.wav',
      'crecendo.wav',
      'burning.wav',
    ]);
    await Flame.images.loadAllImages();

    FlameAudio.bgm.stop();
    FlameAudio.bgm.play('tango.mp3', volume: 0.7);
    await create();
    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      reset();
    }

    if (gameEnd != null) {
      return KeyEventResult.ignored;
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      turtleComponent.pointLeft();
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      turtleComponent.pointRight();
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      turtleComponent.pointForward();
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      turtleComponent.pointBack();
    }

    if (keysPressed.contains(LogicalKeyboardKey.keyO)) {
      spawningEnding();
    }

    return KeyEventResult.handled;
  }

  @override
  void onTapUp(TapUpEvent event) {
    turtleComponent.moveTo(event.localPosition);
    super.onTapUp(event);
  }

  void meteorCrashEnding() {
    FlameAudio.play('gong.wav');
    gameEnd = Ending.meteorCrash;
    overlays.add(Overlays.meteorCrash.toString());
  }

  void superColdEnding() {
    FlameAudio.play('gong.wav');
    gameEnd = Ending.superCold;
    overlays.add(Overlays.superCold.toString());
  }

  void superHotEnding() {
    FlameAudio.play('gong.wav');
    gameEnd = Ending.superHot;
    overlays.add(Overlays.superHot.toString());
  }

  void spawningEnding() {
    FlameAudio.play('gong.wav');
    gameEnd = Ending.spawning;
    turtleComponent.spawnEggs();
    overlays.add(Overlays.spawning.toString());
  }

  int get eggsLeft => targetEggs - turtleComponent.eatenSunsCount;

  @override
  void update(double dt) {
    eggCounterComponent.text = eggsLeft.toString();
    if (eggsLeft <= 0) {
      spawningEnding();
    }

    runSunGeneration();
    updateMeteorGeneration(dt);
    super.update(dt);
  }

  Future<void> create() async {
    await world.add(turtleComponent = TurtleComponent());
    camera.viewport.anchor = Anchor.center;

    // Add background overlay below.
    final belowImage = Flame.images.fromCache('background-below.png');

    final desiredWidth = canvasSize.x;
    final backgroundSize = Vector2(
      desiredWidth,
      desiredWidth * belowImage.size.y / belowImage.size.x,
    );

    add(BackgroundComponent());
    add(
      SpriteComponent()
        ..sprite = Sprite(belowImage)
        ..size = backgroundSize
        ..position = Vector2(0, canvasSize.y * 0.75),
    );
    add(TermostatComponent());

    eggCounterComponent = TextComponent(
      text: (eggsLeft).toString(),
      textRenderer: TextPaint(style: TextStyles.middle.style),
      position: Vector2(canvasSize.x * 0.9, 16),
    );
    add(eggCounterComponent);

    startMeteorGeneration();
  }

  Future<void> reset() async {
    overlays.removeAll(Overlays.values.map((e) => e.toString()));
    removeAll(children);
    add(world = World());
    add(camera = CameraComponent(world: world));
    gameEnd = null;
    meteorCount = 0;
    sunCount = 0;
    await create();
  }
}
