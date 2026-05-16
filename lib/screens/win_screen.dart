import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arrow_escape_puzzle/providers/game_provider.dart';
import 'package:arrow_escape_puzzle/screens/level_select_screen.dart';

class WinScreen extends StatelessWidget {
  final int levelNumber;

  const WinScreen({super.key, required this.levelNumber});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Level Completed!',
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'You completed Level $levelNumber!',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                gameProvider.incrementLevel();
                Navigator.of(context).popUntil((route) => route.isFirst); // Go back to home or level select
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LevelSelectScreen(difficultyId: 1, difficultyName: 'EASY'), // TODO: Pass actual difficulty
                  ),
                ); // Navigate to next level or level select
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              child: const Text('Next Level', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst); // Go back to home
              },
              child: const Text('Back to Home', style: TextStyle(color: Colors.white54)),
            ),
          ],
        ),
      ),
    );
  }
}
