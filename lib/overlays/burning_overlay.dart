import 'package:flutter/material.dart';
import 'package:testudines_solfago/components/my_game.dart';

class BurningOverlay extends StatelessWidget {
  final MyGame game;

  const BurningOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: game.canvasSize.x,
        height: game.canvasSize.y,
        color: Colors.red.withOpacity(0.1),
      ),
    );
  }
}
