import 'package:flutter/material.dart';
import 'package:testudines_solfago/components/my_game.dart';

class FreezingOverlay extends StatelessWidget {
  final MyGame game;

  const FreezingOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: game.canvasSize.x,
        height: game.canvasSize.y,
        color: Colors.blue.withOpacity(0.1),
      ),
    );
  }
}
