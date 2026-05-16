import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'package:arrow_escape_puzzle/game/components/arrow_grid.dart';
import 'package:arrow_escape_puzzle/game/game_manager.dart';

class ArrowEscapeGame extends FlameGame with HasTappables {
  final GameManager gameManager;

  ArrowEscapeGame({required this.gameManager});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Add game components here
    // For now, we'll add a dummy grid. The GameManager will handle actual level loading.
    final arrowGrid = ArrowGrid(rows: 5, cols: 5, tileSize: 64.0);
    add(arrowGrid);
    gameManager.currentGrid = arrowGrid; // Link the grid to the game manager
  }

  @override
  void update(double dt) {
    super.update(dt);
    gameManager.checkWinCondition();
  }
}
