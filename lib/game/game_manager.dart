import 'package:flutter/material.dart';
import 'package:arrow_escape_puzzle/game/components/arrow_grid.dart';

class GameManager extends ChangeNotifier {
  ArrowGrid? currentGrid;
  // TODO: Add level loading, win/lose conditions, etc.

  void loadLevel(int levelNumber) {
    // This is a placeholder. Actual level loading logic will be more complex.
    // For now, let's just create a dummy grid.
    currentGrid = ArrowGrid(rows: 5, cols: 5, tileSize: 64.0);
    notifyListeners();
  }

  void resetLevel() {
    // TODO: Implement level reset logic
    notifyListeners();
  }

  void checkWinCondition() {
    if (currentGrid != null && currentGrid!.checkWinCondition()) {
      // TODO: Handle win state
      print('Level Completed!');
    }
  }
}
