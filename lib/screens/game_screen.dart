import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:arrow_escape_puzzle/game/arrow_escape_game.dart';
import 'package:arrow_escape_puzzle/game/game_manager.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GameManager>(
        builder: (context, gameManager, child) {
          if (gameManager.currentGrid == null) {
            gameManager.loadLevel(1); // Load a default level for now
          }
          return GameWidget(
            game: ArrowEscapeGame(gameManager: gameManager),
          );
        },
      ),
    );
  }
}
