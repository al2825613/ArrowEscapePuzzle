import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arrow_escape_puzzle/providers/game_provider.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Shop', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Your Coins: ${gameProvider.coins}',
                  style: const TextStyle(color: Colors.yellow, fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(16.0),
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: [
                    _buildShopItem(
                      context,
                      gameProvider,
                      'Extra Life',
                      'Restore 1 life',
                      50,
                      Icons.favorite,
                      Colors.red,
                      () => gameProvider.restoreLife(),
                    ),
                    _buildShopItem(
                      context,
                      gameProvider,
                      'Hint Pack',
                      '5 Hints',
                      100,
                      Icons.lightbulb,
                      Colors.yellow,
                      () => gameProvider.addCoins(0), // Placeholder for adding hints
                    ),
                    // TODO: Add themes and other items
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildShopItem(
    BuildContext context,
    GameProvider gameProvider,
    String title,
    String description,
    int cost,
    IconData icon,
    Color iconColor,
    VoidCallback onBuy,
  ) {
    return Card(
      color: Colors.grey[900],
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () async {
          if (gameProvider.coins >= cost) {
            final success = await gameProvider.removeCoins(cost);
            if (success) {
              onBuy();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You bought $title!')), 
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to complete purchase.')), 
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Not enough coins!')), 
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: iconColor),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              description,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$cost Coins',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
