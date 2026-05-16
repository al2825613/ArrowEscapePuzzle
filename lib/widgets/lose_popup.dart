import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arrow_escape_puzzle/providers/game_provider.dart';

class LosePopup extends StatelessWidget {
  const LosePopup({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context, listen: false);

    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: const Text(
        'Game Over!',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'You ran out of lives.',
            style: TextStyle(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close popup
              gameProvider.watchAdForLife(); // Offer to watch ad
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Watch Ad for 1 Life', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close popup
              // TODO: Navigate back to level select or home screen
              print('Go back to menu');
            },
            child: const Text('Back to Menu', style: TextStyle(color: Colors.white54)),
          ),
        ],
      ),
    );
  }
}
