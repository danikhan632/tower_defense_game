import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../game/game.dart';
import 'pause_menu.dart';
import 'package:tower_defense/game/AudioManager.dart';

// This class represents the pause button overlay.
class PauseButton extends StatelessWidget {
  static const String ID = 'PauseButton';
  final TowerDefenseGame gameRef;

  const PauseButton({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: IconButton(
        iconSize: 72,
        enableFeedback: true,
        color: Colors.black,
        icon: Icon(
          Icons.pause_rounded,
        ),
        onPressed: () {
          gameRef.pauseEngine();
          AudioManager.instance.pauseBgm();
          gameRef.overlays.add(PauseMenu.ID);
          gameRef.overlays.remove(PauseButton.ID);
        },
      ),
    );
  }
}
