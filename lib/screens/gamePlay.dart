import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/game/game.dart';

import '../game/game.dart';
import '../widgets/overlays/pause_button.dart';
import '../widgets/overlays/pause_menu.dart';

// Creating this as a file private object so as to
// avoid unwanted rebuilds of the whole game object.'

int number = 0;

// This class represents the actual game screen
// where all the action happens.
class GamePlay extends StatelessWidget {
  const GamePlay({Key? key, required this.param}) : super(key: key);
  final int param;
  @override
  Widget build(BuildContext context) {
    TowerDefenseGame _towerDefenseGame = TowerDefenseGame(
        param, MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return Scaffold(
      // WillPopScope provides us a way to decide if
      // this widget should be poped or not when user
      // presses the back button.
      body: WillPopScope(
        onWillPop: () async => false,
        // GameWidget is useful to inject the underlying
        // widget of any class extending from Flame's Game class.
        child: GameWidget(
          game: _towerDefenseGame,
          // Initially only pause button overlay will be visible.
          initialActiveOverlays: [PauseButton.ID],
          overlayBuilderMap: {
            PauseButton.ID: (BuildContext context, TowerDefenseGame gameRef) =>
                PauseButton(
                  gameRef: gameRef,
                ),
            PauseMenu.ID: (BuildContext context, TowerDefenseGame gameRef) =>
                PauseMenu(
                  gameRef: gameRef,
                ),
          },
        ),
      ),
    );
  }
}
