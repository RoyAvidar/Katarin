import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:katarin/components/map_component.dart';
import 'package:katarin/components/pause_component.dart';
import 'package:katarin/components/rocket_info.dart';
import 'package:katarin/fixed_vertical_resolution_viewport.dart';
import 'package:katarin/game_state.dart';
import 'package:katarin/widgets/pause_menu.dart';
import 'package:katarin/components/rocket_component.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();
  await Flame.device.fullScreen();
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
class MoonlanderGame extends FlameGame
    with
        HasCollidables,
        HasTappables,
        HasKeyboardHandlerComponents,
        HasDraggables {
  void onOverlayChanged() {
    if (overlays.isActive('pause')) {
      pauseEngine();
    } else {
      resumeEngine();
    }
  }

  @override
  bool get debugMode => GameState.showDebugInfo;

  /// Restart the current level.
  void restart() {
    // TODO: Implement restart of current level.
    GameState.playState = PlayingState.palying;
    final rocket = children.firstWhere((child) => child is RocketComponent)
        as RocketComponent;
    rocket.reset();
  }

  @override
  void onMount() {
    overlays.addListener(onOverlayChanged);
    super.onMount();
  }

  @override
  void onRemove() {
    overlays.removeListener(onOverlayChanged);
    super.onRemove();
  }

  @override
  Future<void> onLoad() async {
    final image = await images.load('joystick.png');
    final sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 6,
      rows: 1,
    );
    camera.viewport = FixedVerticalResolutionViewport(400);

    ///Ensure our joystick knob is between 50 and 100 based on view height
    ///Important its based on device size not viewport size
    ///8.2 is the "magic" hud joystick factor... ;)
    final knobSize = min(max(50, size.y / 8.2), 100).toDouble();

    final joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: sheet.getSpriteById(1),
        size: Vector2.all(knobSize),
      ),
      background: SpriteComponent(
        sprite: sheet.getSpriteById(0),
        size: Vector2.all(knobSize * 1.5),
      ),
      margin: const EdgeInsets.only(left: 10, bottom: 10),
    );
    final rocket = RocketComponent(
      position: size / 2,
      size: Vector2(32, 48),
      joystick: joystick,
    );
    unawaited(add(rocket));
    unawaited(add(joystick));
    unawaited(add(MapComponent()));
    unawaited(add(RocketInfo(rocket)));
    unawaited(
      add(
        PauseComponent(
          margin: const EdgeInsets.only(
            top: 10,
            left: 5,
          ),
          sprite: await Sprite.load('PauseButton.png'),
          spritePressed: await Sprite.load('pause_button_invert.png'),
          onPressed: () {
            if (overlays.isActive('pause')) {
              overlays.remove('pause');
              if (GameState.playState == PlayingState.paused) {
                GameState.playState = PlayingState.palying;
              }
            } else {
              if (GameState.playState == PlayingState.palying) {
                GameState.playState = PlayingState.paused;
              }

              overlays.add('pause');
            }
          },
        ),
      ),
    );

    overlays.addListener(onOverlayChanged);
    return super.onLoad();
  }
}
