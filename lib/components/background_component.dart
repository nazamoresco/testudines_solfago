import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:testudines_solfago/components/my_game.dart';

class BackgroundComponent extends SpriteComponent with HasGameRef<MyGame> {
  @override
  FutureOr<void> onLoad() {
    final image = Flame.images.fromCache('background.jpg');
    sprite = Sprite(image);

    final desiredWidth = game.canvasSize.x;
    size = Vector2(
      desiredWidth,
      desiredWidth * image.size.y / image.size.x,
    );
  }
}
