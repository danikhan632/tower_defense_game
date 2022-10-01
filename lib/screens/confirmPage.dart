import 'dart:ui';
import 'dart:io';
import 'package:tower_defense/screens/playerName_Diff.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/screens/gamePlay.dart';
import 'package:tower_defense/game/game.dart';

// This represents the main menu overlay.
class confirmPage extends StatelessWidget {
  confirmPage({Key? key, required this.param, required this.param2}) : super(key: key);
  // An unique identified for this overlay.
  final int param;
  final String param2;
  // Reference to parent game.

  //const PlayerMenu({Key? key}) : super(key: key);
  String difficulty(int num) {
    if (num == 150) {
      return "Easy";
    } else if (num == 100) {
      return "Medium";
    }
    return "Hard";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Start game with these settings?',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Player Name: ' + param2,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Difficulty: ' + difficulty(param),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
        ),
        ElevatedButton(
          child: Text('Start game'),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => GamePlay(param: param)),
            );
            //easy mode
          },
        ),
        ElevatedButton(
          child: Text('Go back'),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => PlayerMenu()),
            );
            //easy mode
          },
        ),
        ElevatedButton(
          child: Text('Quit Game'),
          onPressed: () {
            // Navigate to the game screen.
            exit(0);
          },
        ),
      ],
    )));
  }
}
