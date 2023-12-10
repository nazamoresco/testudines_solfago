import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:testudines_solfago/components/my_game.dart';
import 'package:testudines_solfago/enums/overlays.dart';
import 'package:testudines_solfago/overlays/burning_overlay.dart';
import 'package:testudines_solfago/overlays/freezing_overlay.dart';
import 'package:testudines_solfago/overlays/meteor_crash_overlay.dart';
import 'package:testudines_solfago/overlays/spawning_overlay.dart';
import 'package:testudines_solfago/overlays/super_cold_overlay.dart';
import 'package:testudines_solfago/overlays/super_hot_overlay.dart';
import 'package:testudines_solfago/screens/choose_language_screen.dart';
import 'package:testudines_solfago/screens/intro_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: const ChooseLanguageScreen(),
      routes: {
        '/intro': (context) => const IntroScreen(),
        '/game': (context) => GameWidget(
              game: MyGame(),
              overlayBuilderMap: {
                Overlays.meteorCrash.toString(): (context, MyGame game) =>
                    MeteorCrashOverlay(game),
                Overlays.superCold.toString(): (context, MyGame game) =>
                    SuperColdOverlay(game),
                Overlays.superHot.toString(): (context, MyGame game) =>
                    SuperHotOverlay(game),
                Overlays.spawning.toString(): (context, MyGame game) =>
                    SpawningOverlay(game),
                Overlays.freezing.toString(): (context, MyGame game) =>
                    FreezingOverlay(game),
                Overlays.burning.toString(): (context, MyGame game) =>
                    BurningOverlay(game),
              },
            ),
      },
    ),
  );
}
