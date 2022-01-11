import 'package:flutter/material.dart';

abstract class BaseWidget {
  void resize(Size size);

  void render(Canvas canvas);

  void upload();
}
