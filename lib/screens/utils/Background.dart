import 'dart:ui';

import 'package:flame/components.dart';
import 'package:katarin/screens/base_widget.dart';

class Background extends BaseWidget {
  late final SpriteComponent _bgSprite;

  Background(String src) {
    // _bgSprite = SpriteComponent.fromImage();
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    _bgSprite.render(canvas);
  }

  @override
  void resize(Size size) {
    // TODO: implement resize
    _bgSprite.width = size.width;
    _bgSprite.height = size.height;
  }

  @override
  void upload() {}
}
