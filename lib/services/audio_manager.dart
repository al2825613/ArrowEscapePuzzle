import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioManager with ChangeNotifier {
  AudioPlayer _backgroundPlayer = AudioPlayer();
  AudioPlayer _sfxPlayer = AudioPlayer();

  bool _isBackgroundMusicEnabled = true;
  bool _isSfxEnabled = true;

  bool get isBackgroundMusicEnabled => _isBackgroundMusicEnabled;
  bool get isSfxEnabled => _isSfxEnabled;

  AudioManager() {
    _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> playBackgroundMusic(String assetPath) async {
    if (_isBackgroundMusicEnabled) {
      await _backgroundPlayer.play(AssetSource(assetPath));
    }
  }

  Future<void> stopBackgroundMusic() async {
    await _backgroundPlayer.stop();
  }

  Future<void> playSfx(String assetPath) async {
    if (_isSfxEnabled) {
      await _sfxPlayer.play(AssetSource(assetPath));
    }
  }

  void toggleBackgroundMusic() {
    _isBackgroundMusicEnabled = !_isBackgroundMusicEnabled;
    if (_isBackgroundMusicEnabled) {
      // TODO: Resume background music if it was playing
    } else {
      stopBackgroundMusic();
    }
    notifyListeners();
  }

  void toggleSfx() {
    _isSfxEnabled = !_isSfxEnabled;
    notifyListeners();
  }

  @override
  void dispose() {
    _backgroundPlayer.dispose();
    _sfxPlayer.dispose();
    super.dispose();
  }
}
