import 'package:flutter/material.dart';

import 'package:arrow_escape_puzzle/services/ad_service.dart';
import 'package:arrow_escape_puzzle/game/coins_manager.dart';

class GameProvider with ChangeNotifier {
  final AdService _adService;
  final CoinsManager _coinsManager;

  GameProvider({required AdService adService}) : _adService = adService, _coinsManager = CoinsManager();
  // TODO: Implement game state management here
  int _currentLevel = 1;
  int _lives = 3;

  int get currentLevel => _currentLevel;
  AdService get adService => _adService;
  int get coins => _coinsManager.coins;
  int get lives => _lives;

  void incrementLevel() {
    _currentLevel++;
    notifyListeners();
  }

  Future<void> addCoins(int amount) async {
    await _coinsManager.addCoins(amount);
    notifyListeners();
  }

  Future<bool> removeCoins(int amount) async {
    final success = await _coinsManager.removeCoins(amount);
    notifyListeners();
    return success;
  }

  void loseLife() {
    if (_lives > 0) {
      _lives--;
      notifyListeners();
    } else {
      // TODO: Show lose popup and offer to watch ad for life
      print('Game Over! Watch ad for life?');
    }
  }

  void restoreLife() {
    if (_lives < 3) { // Max lives is 3
      _lives++;
      notifyListeners();
    }
  }

  void watchAdForLife() {
    _adService.showRewardedAd(onRewardEarned: () {
      restoreLife();
    });
  }

  // Other game state and logic will be added here
}
