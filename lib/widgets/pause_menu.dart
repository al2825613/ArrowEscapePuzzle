import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arrow_escape_puzzle/services/audio_manager.dart';

class PauseMenu extends StatelessWidget {
  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onExit;

  const PauseMenu({
    super.key,
    required this.onResume,
    required this.onRestart,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    final audioManager = Provider.of<AudioManager>(context);

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.blueAccent, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Paused',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            _buildMenuButton(context, 'Resume', onResume),
            const SizedBox(height: 15),
            _buildMenuButton(context, 'Restart', onRestart),
            const SizedBox(height: 15),
            _buildMenuButton(context, 'Settings', () {
              // TODO: Navigate to Settings Screen
              print('Open Settings from Pause Menu');
            }),
            const SizedBox(height: 15),
            _buildMenuButton(context, 'Exit', onExit),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.music_note, color: Colors.white),
                Switch(
                  value: audioManager.isBackgroundMusicEnabled,
                  onChanged: (value) {
                    audioManager.toggleBackgroundMusic();
                  },
                  activeColor: Colors.blueAccent,
                ),
                const SizedBox(width: 20),
                const Icon(Icons.volume_up, color: Colors.white),
                Switch(
                  value: audioManager.isSfxEnabled,
                  onChanged: (value) {
                    audioManager.toggleSfx();
                  },
                  activeColor: Colors.blueAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey[700],
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
