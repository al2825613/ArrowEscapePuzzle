import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:arrow_escape_puzzle/game/arrow_escape_game.dart';
import 'package:arrow_escape_puzzle/providers/game_provider.dart';
import 'package:arrow_escape_puzzle/screens/splash_screen.dart';
import 'package:arrow_escape_puzzle/game/game_manager.dart';
import 'package:arrow_escape_puzzle/services/local_storage_service.dart';
import 'package:arrow_escape_puzzle/services/ad_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init(); // Initialize local storage
  final adService = AdService();
  adService.loadRewardedAd(); // Load rewarded ad at startup

  runApp(MyApp(adService: adService));
}

class MyApp extends StatelessWidget {
  final AdService adService;
  const MyApp({super.key, required this.adService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameProvider(adService: adService)),
        ChangeNotifierProxyProvider<GameProvider, HintManager>(
          create: (context) => HintManager(gameProvider: context.read<GameProvider>()),
          update: (context, gameProvider, hintManager) => HintManager(gameProvider: gameProvider),
        ),
        ChangeNotifierProvider(create: (_) => GameManager()),
        ChangeNotifierProvider(create: (_) => AudioManager()),
      ],
      child: MaterialApp(
        title: 'Arrow Escape Puzzle',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
