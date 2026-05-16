import 'package:flutter/material.dart';
import 'package:arrow_escape_puzzle/screens/game_screen.dart';

class LevelSelectScreen extends StatelessWidget {
  final int difficultyId;
  final String difficultyName;

  const LevelSelectScreen({super.key, required this.difficultyId, required this.difficultyName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('$difficultyName Levels', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: 50, // 50 levels per difficulty
        itemBuilder: (context, index) {
          final levelNumber = index + 1;
          return GestureDetector(
            onTap: () {
              // TODO: Implement level locking/unlocking logic
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameplayScreen(levelNumber: levelNumber), // Pass level data to GameplayScreen
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[800],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  '$levelNumber',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
