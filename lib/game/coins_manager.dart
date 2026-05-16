import 'package:flutter/material.dart';
import 'package:arrow_escape_puzzle/services/local_storage_service.dart';

class CoinsManager with ChangeNotifier {
  static const String _coinsKey = 'player_coins';
  int _coins = 0;

  int get coins => _coins;

  CoinsManager() {
    _loadCoins();
  }

  Future<void> _loadCoins() async {
    _coins = LocalStorageService.getInt(_coinsKey) ?? 0;
    notifyListeners();
  }

  Future<void> addCoins(int amount) async {
    _coins += amount;
    await LocalStorageService.saveInt(_coinsKey, _coins);
    notifyListeners();
  }

  Future<bool> removeCoins(int amount) async {
    if (_coins >= amount) {
      _coins -= amount;
      await LocalStorageService.saveInt(_coinsKey, _coins);
      notifyListeners();
      return true;
    }
    return false;
  }
}
