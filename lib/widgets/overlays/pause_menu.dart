import 'dart:ui';

import 'package:tower_defense/screens/confirmPage.dart';
import 'package:tower_defense/screens/gamePlay.dart';
import 'package:tower_defense/game/AudioManager.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import '/game/game.dart';
import 'pause_button.dart';
import '../../../screens/mainMenu.dart';

class PauseMenu extends StatelessWidget {
  static const String ID = 'PauseMenu';
  final TowerDefenseGame gameRef;
  final int health = 69;
  const PauseMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pause menu title.
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              'Paused',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.black,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.white,
                    offset: Offset(0, 0),
                  )
                ],
              ),
            ),
          ),

          // Resume button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                gameRef.resumeEngine();
                AudioManager.instance.resumeBgm();
                gameRef.overlays.remove(PauseMenu.ID);
                gameRef.overlays.add(PauseButton.ID);
              },
              child: Text('Resume'),
            ),
          ),

          // Restart button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                gameRef.reset();
                int num = (gameRef.getInitMoney() / 2).toInt();
                String str = "";
                if (num == 150) {
                  str = "Easy";
                }
                if (num == 100) {
                  str = "Medium";
                }
                if (num == 50) {
                  str = "Hard";
                }

                gameRef.overlays.remove(PauseMenu.ID);
                gameRef.overlays.add(PauseButton.ID);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => confirmPage(param: num, param2: str),
                  ),
                );
              },
              child: Text('Restart'),
            ),
          ),

          // Exit button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                gameRef.overlays.remove(PauseMenu.ID);
                // gameRef.reset();

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MainMenu(),
                  ),
                );
              },
              child: Text('Exit'),
            ),
          ),
        ],
      ),
    );
  }
}
