import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:katarin/main.dart';

class PauseComponent extends SpriteComponent
    with Tappable, HasGameRef<MoonlanderGame> {
  /// Position to show the button.
  PauseComponent({
    required Vector2 position,
    required Sprite sprite,
  }) : super(position: position, size: Vector2(50, 25), sprite: sprite);

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
