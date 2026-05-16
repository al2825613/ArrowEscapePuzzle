import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arrow_escape_puzzle/services/audio_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Consumer<AudioManager>(
        builder: (context, audioManager, child) {
          return ListView(
            children: [
              SwitchListTile(
                title: const Text('Background Music', style: TextStyle(color: Colors.white)),
                value: audioManager.isBackgroundMusicEnabled,
                onChanged: (value) {
                  audioManager.toggleBackgroundMusic();
                },
                activeColor: Colors.blueAccent,
              ),
              SwitchListTile(
                title: const Text('Sound Effects', style: TextStyle(color: Colors.white)),
                value: audioManager.isSfxEnabled,
                onChanged: (value) {
                  audioManager.toggleSfx();
                },
                activeColor: Colors.blueAccent,
              ),
              // TODO: Add more settings like Haptic Feedback toggle
            ],
          );
        },
      ),
    );
  }
}
