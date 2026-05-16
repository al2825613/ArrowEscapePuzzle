import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arrow_escape_puzzle/game/hint_manager.dart';
import 'package:arrow_escape_puzzle/services/audio_manager.dart';
import 'package:arrow_escape_puzzle/widgets/lose_popup.dart';

import 'package:arrow_escape_puzzle/game/arrow_escape_game.dart';
import 'package:arrow_escape_puzzle/game/game_manager.dart';
import 'package:arrow_escape_puzzle/providers/game_provider.dart';

class GameplayScreen extends StatelessWidget {
  final int levelNumber;

  const GameplayScreen({super.key, required this.levelNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer2<GameManager, GameProvider>(
            builder: (context, gameManager, gameProvider, child) {
              if (gameManager.currentGrid == null) {
                gameManager.loadLevel(levelNumber); // Load the specific level
              }
              // Listen for lives and show popup if 0
              if (gameProvider.lives == 0) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const LosePopup();
                    },
                  );
                });
              }
              return GameWidget(
                game: ArrowEscapeGame(gameManager: gameManager),
              );
            },
          ),
          // HUD Overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Consumer<GameProvider>(
                builder: (context, gameProvider, child) {
                  return Text(
                    'Level: ${gameProvider.currentLevel}',
                    style: const TextStyle(color: Colors.white),
                  );
                },
              ),
              actions: [
                Consumer3<GameProvider, HintManager, AudioManager>(
                  builder: (context, gameProvider, hintManager, audioManager, child) {
                    return Row(
                      children: [
                        const Icon(Icons.favorite, color: Colors.red),
                        Text('${gameProvider.lives}', style: const TextStyle(color: Colors.white)),
                        const SizedBox(width: 10),
                        const Icon(Icons.monetization_on, color: Colors.yellow),
                        Text('${gameProvider.coins}', style: const TextStyle(color: Colors.white)),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: Icon(Icons.lightbulb, color: hintManager.canAffordHint() ? Colors.white : Colors.grey),
                          onPressed: () {
                            if (hintManager.canAffordHint()) {
                              hintManager.useHint();
                              audioManager.playSfx('audio/hint_sfx.mp3'); // Play hint sound
                            } else {
                              // TODO: Show message: Not enough coins
                              print('Not enough coins for a hint.');
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.pause, color: Colors.white),
                          onPressed: () {
                            audioManager.playSfx("audio/click_sfx.mp3"); // Play click sound
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return PauseMenu(
                                  onResume: () {
                                    Navigator.of(context).pop();
                                    // TODO: Resume game logic
                                  },
                                  onRestart: () {
                                    Navigator.of(context).pop();
                                    // TODO: Restart level logic
                                  },
                                  onExit: () {
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
