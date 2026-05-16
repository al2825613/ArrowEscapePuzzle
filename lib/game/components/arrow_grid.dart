import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import 'package:arrow_escape_puzzle/game/components/arrow.dart';

class ArrowGrid extends PositionComponent with TapCallbacks {
  final int rows;
  final int cols;
  final double tileSize;
  late List<List<Arrow?>> grid;

  ArrowGrid({required this.rows, required this.cols, required this.tileSize}) {
    size = Vector2(cols * tileSize, rows * tileSize);
    grid = List.generate(rows, (_) => List.generate(cols, (_) => null));
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Example: Add some arrows
    _addArrow(0, 0, ArrowDirection.right);
    _addArrow(0, 1, ArrowDirection.down);
  }

  void _addArrow(int row, int col, ArrowDirection direction) {
    final arrow = Arrow(
      direction: direction,
      position: Vector2(col * tileSize + tileSize / 2, row * tileSize + tileSize / 2),
      size: Vector2.all(tileSize * 0.8),
      anchor: Anchor.center,
    );
    grid[row][col] = arrow;
    add(arrow);
  }

  @override
  void onTapDown(TapDownEvent event) {
    final tapPosition = event.canvasPosition;
    final gridX = (tapPosition.x / tileSize).floor();
    final gridY = (tapPosition.y / tileSize).floor();

    if (gridX >= 0 && gridX < cols && gridY >= 0 && gridY < rows) {
      final tappedArrow = grid[gridY][gridX];
      if (tappedArrow != null) {
        tappedArrow.rotate();
        // TODO: Implement win condition check here
      }
    }
  }

  // TODO: Implement win condition algorithm
  bool checkWinCondition() {
    // This is a placeholder. Actual logic will be complex.
    return false;
  }
}
