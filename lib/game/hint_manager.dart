import 'package:flutter/material.dart';
import 'package:arrow_escape_puzzle/providers/game_provider.dart';

class HintManager with ChangeNotifier {
  final GameProvider _gameProvider;
  final int hintCost = 10; // Cost of one hint

  HintManager({required GameProvider gameProvider}) : _gameProvider = gameProvider;

  bool canAffordHint() {
    return _gameProvider.coins >= hintCost;
  }

  Future<bool> useHint() async {
    if (canAffordHint()) {
      final success = await _gameProvider.removeCoins(hintCost);
      if (success) {
        // TODO: Implement logic to reveal a correct arrow in the game grid
        print('Hint used! Coins remaining: ${_gameProvider.coins}');
        notifyListeners();
        return true;
      }
    }
    print('Not enough coins for a hint.');
    return false;
  }
}
