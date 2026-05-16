import 'package:flutter/material.dart';
import 'package:arrow_escape_puzzle/services/local_storage_service.dart';
import 'package:arrow_escape_puzzle/providers/game_provider.dart';

class DailyRewardManager with ChangeNotifier {
  static const String _lastClaimDateKey = 'last_daily_reward_claim_date';
  final GameProvider _gameProvider;

  DailyRewardManager({required GameProvider gameProvider}) : _gameProvider = gameProvider;

  Future<bool> canClaimDailyReward() async {
    final lastClaimDateString = LocalStorageService.getString(_lastClaimDateKey);
    if (lastClaimDateString == null) {
      return true; // Never claimed before
    }

    final lastClaimDate = DateTime.parse(lastClaimDateString);
    final now = DateTime.now();

    // Check if it's a new day (ignoring time)
    return now.year > lastClaimDate.year ||
           (now.year == lastClaimDate.year && now.month > lastClaimDate.month) ||
           (now.year == lastClaimDate.year && now.month == lastClaimDate.month && now.day > lastClaimDate.day);
  }

  Future<void> claimDailyReward() async {
    if (await canClaimDailyReward()) {
      // Award coins and lives
      await _gameProvider.addCoins(50); // Example reward
      _gameProvider.restoreLife(); // Example reward

      // Save today's date as last claim date
      await LocalStorageService.saveString(_lastClaimDateKey, DateTime.now().toIso8601String());
      notifyListeners();
      print('Daily reward claimed!');
    } else {
      print('Daily reward already claimed today.');
    }
  }
}
