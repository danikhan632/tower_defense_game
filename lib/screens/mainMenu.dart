import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tower_defense/game/AudioManager.dart';
import 'package:tower_defense/screens/playerName_Diff.dart';
import 'package:tower_defense/game/game.dart';

// This represents the main menu overlay.
class MainMenu extends StatelessWidget {
  // A unique identifier for this overlay.

  // Reference to parent game.
  Future<void> onLoad() async {
    AudioManager.instance.init(['vamp.mp3', 'gun.mp3', 'laser.mp3']);
  }

  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Tower Defense',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          child: const Text('Start Game'),
          onPressed: () {
            // Navigate to the game screen.

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => PlayerMenu(),
              ),
            );
          },
        ),
        ElevatedButton(
          child: const Text('Quit Game'),
          onPressed: () {
            // Navigate to the game screen.
            exit(0);
          },
        ),
      ],
    )));
  }
}
