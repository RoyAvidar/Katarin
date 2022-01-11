import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


// class MyCrate extends SpriteComponent {
//   // creates a component that renders the crate.png sprite, with size 16 x 16
//   MyCrate() : super(size: Vector2.all(16));

//   Future<void> onLoad() async {
//     sprite = await Sprite.load('crate.png');
//     anchor = Anchor.center;
//   }

//   @override
//   void onGameResize(Vector2 gameSize) {
//     super.onGameResize(gameSize);
//     // We don't need to set the position in the constructor, we can set it directly here since it will
//     // be called once before the first time it is rendered.
//     position = gameSize / 2;
//   }
// }

// class MyGame extends FlameGame {
//   @override
//   Future<void> onLoad() async {
//     await super.onLoad();
//     add(MyCrate());
//   }
// }

// main() {
//   final myGame = MyGame();
//   runApp(
//     GameWidget(
//       game: myGame,
//     ),
//   );
// }