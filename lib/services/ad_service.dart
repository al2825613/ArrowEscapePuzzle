import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';

class AdService {
  RewardedAd? _rewardedAd;
  bool _isRewardedAdReady = false;

  final String _adUnitId = kReleaseMode
      ? 'YOUR_PRODUCTION_AD_UNIT_ID' // TODO: Replace with your production ad unit ID
      : 'ca-app-pub-3940256099942544/5224354917'; // Test Ad Unit ID

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isRewardedAdReady = true;
          debugPrint('Rewarded ad loaded.');
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
          _isRewardedAdReady = false;
          debugPrint('Failed to load rewarded ad: $error');
        },
      ),
    );
  }

  void showRewardedAd({required Function onRewardEarned}) {
    if (_isRewardedAdReady && _rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _isRewardedAdReady = false;
          loadRewardedAd(); // Load the next ad
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _isRewardedAdReady = false;
          debugPrint('Failed to show rewarded ad: $error');
          loadRewardedAd(); // Load the next ad
        },
      );

      _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
        debugPrint('User earned reward: ${reward.amount} ${reward.type}');
        onRewardEarned();
      });
    } else {
      debugPrint('Rewarded ad is not ready yet.');
      loadRewardedAd(); // Try to load again if not ready
    }
  }

  void dispose() {
    _rewardedAd?.dispose();
  }
}
