import 'dart:async';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:katarin/widgets/pause_menu.dart';
import 'package:katarin/components/rocket_component.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();

  final game = MoonlanderGame();

  runApp(
    MaterialApp(
      home: GameWidget(
        game: game,
        loadingBuilder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorBuilder: (context, err) {
          debugPrint(err.toString());
          return const Center(
            child: Text('Sorry, somthing went wrong. Reload me'),
          );
        },
        overlayBuilderMap: {
          'pause': (context, MoonlanderGame game) => PauseMenu(game: game),
        },
      ),
    ),
  );
}

/// This class encapulates the whole game.
class MoonlanderGame extends FlameGame with HasCollidables {
  @override
  Future<void> onLoad() async {
    unawaited(add(RocketComponent(position: size / 2, size: Vector2.all(20))));

    return super.onLoad();
  }
}
