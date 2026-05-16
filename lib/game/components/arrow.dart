import 'package:flame/components.dart';
import 'package:flutter/material.dart';

enum ArrowDirection {
  up, down, left, right
}

class Arrow extends SpriteComponent {
  ArrowDirection direction;

  Arrow({
    required this.direction,
    required super.position,
    required super.size,
    super.anchor,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load(
      _getArrowAssetPath(direction),
      srcSize: Vector2.all(32),
    );
    angle = _getRotationAngle(direction);
  }

  String _getArrowAssetPath(ArrowDirection dir) {
    switch (dir) {
      case ArrowDirection.up:
        return 'images/arrow_up.png';
      case ArrowDirection.down:
        return 'images/arrow_down.png';
      case ArrowDirection.left:
        return 'images/arrow_left.png';
      case ArrowDirection.right:
        return 'images/arrow_right.png';
    }
  }

  double _getRotationAngle(ArrowDirection dir) {
    switch (dir) {
      case ArrowDirection.up:
        return 0;
      case ArrowDirection.right:
        return radians(90);
      case ArrowDirection.down:
        return radians(180);
      case ArrowDirection.left:
        return radians(270);
    }
  }

  void rotate() {
    switch (direction) {
      case ArrowDirection.up:
        direction = ArrowDirection.right;
        break;
      case ArrowDirection.right:
        direction = ArrowDirection.down;
        break;
      case ArrowDirection.down:
        direction = ArrowDirection.left;
        break;
      case ArrowDirection.left:
        direction = ArrowDirection.up;
        break;
    }
    angle = _getRotationAngle(direction);
    // TODO: Add smooth rotation animation
  }
}
