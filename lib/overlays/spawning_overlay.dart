import 'package:flutter/material.dart';
import 'package:testudines_solfago/components/my_game.dart';
import 'package:testudines_solfago/enums/contents.dart';
import 'package:testudines_solfago/enums/text_styles.dart';

class SpawningOverlay extends StatelessWidget {
  final MyGame game;

  const SpawningOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: game.reset,
      child: Container(
        width: game.canvasSize.x,
        height: game.canvasSize.y,
        color: Colors.black.withOpacity(0.5),
        child: Container(
          width: game.canvasSize.x / 2,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Contents.spawning.get(
                  eggsEaten: game.turtleComponent.eatenSunsCount,
                ),
                style: TextStyles.middle.style,
              ),
              const SizedBox(height: 32),
              Text(
                Contents.tapToReplay.get(),
                style: TextStyles.small.style,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
