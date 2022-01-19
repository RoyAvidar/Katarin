import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:katarin/main.dart';

class PauseComponent extends HudButtonComponent {
  /// Position to show the button.
  PauseComponent({
    required EdgeInsets margin,
    required Sprite sprite,
    required VoidCallback onPressed,
    Sprite? spritePressed,
  }) : super(
          button: SpriteComponent(
            position: Vector2.zero(),
            sprite: sprite,
            size: Vector2(50, 25),
          ),
          buttonDown: SpriteComponent(
            position: Vector2.zero(),
            sprite: spritePressed,
            size: Vector2(50, 25),
          ),
          margin: margin,
          onPressed: onPressed,
        );

  @override
  bool get isHud => true;

  //HasGameRef offers a clean way to get the current game instance your component is connected to.
  @override
  bool onTapDown(TapDownInfo info) {
    if (gameRef.overlays.isActive('pause')) {
      gameRef.overlays.remove('pause');
    } else {
      gameRef.overlays.add('pause');
    }

    return super.onTapDown(info);
  }
}
