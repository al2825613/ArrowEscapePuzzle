import 'package:flutter/material.dart';
import 'package:arrow_escape_puzzle/screens/level_select_screen.dart';

class DifficultySelectScreen extends StatelessWidget {
  const DifficultySelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Select Difficulty', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDifficultyButton(context, 'EASY', 1),
            const SizedBox(height: 20),
            _buildDifficultyButton(context, 'MEDIUM', 2),
            const SizedBox(height: 20),
            _buildDifficultyButton(context, 'HARD', 3),
            const SizedBox(height: 20),
            _buildDifficultyButton(context, 'EXPERT', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(BuildContext context, String text, int difficultyId) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LevelSelectScreen(difficultyId: difficultyId, difficultyName: text),
          ),
        );
      },
      child: Text(text),
    );
  }
}
