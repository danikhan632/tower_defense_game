import 'dart:ui';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/screens/confirmPage.dart';
import 'package:tower_defense/game/game.dart';
import 'package:tower_defense/screens/playerName_Diff.dart';

// This represents the main menu overlay.
class PlayerMenu extends StatelessWidget {
  // An unique identified for this overlay.

  // Reference to parent game.

  bool nameisValid(String strName) {
    try {
      if (strName == null) {
        return false;
      }
    } catch (e) {
      return false;
    }
    if (strName.length <= 2) {
      return false;
    } else {
      int spaceCount = 0;
      for (int i = 0; i < strName.length; i++) {
        if (strName[i] == ' ') {
          spaceCount++;
        }
      }
      if (spaceCount == strName.length) {
        return false;
      }
    }
    void confirm() {}
    return true;
  }

  int get_difficulty(String diff) {
    if (diff == 'Easy') {
      return 150;
    } else if (diff == 'Medium') {
      return 100;
    } else if (diff == 'Hard') {
      return 50;
    } else {
      throw Exception('Invalid difficulty');
    }
  }

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
          child: TextFormField(
            controller: myController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your username',
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: ElevatedButton(
                    child: const Text('Easy Mode'),
                    onPressed: () {
                      if (nameisValid(myController.text)) {
                        int difficulty = get_difficulty('Easy');
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => confirmPage(
                                  param: difficulty,
                                  param2: myController.text)),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: ElevatedButton(
                      child: const Text('Normal Mode'),
                      onPressed: () {
                        //normal mode
                        if (nameisValid(myController.text)) {
                          int difficulty = get_difficulty('Medium');
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => confirmPage(
                                    param: difficulty,
                                    param2: myController.text)),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                      )),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: ElevatedButton(
                      child: const Text('Hard Mode'),
                      onPressed: () {
                        if (nameisValid(myController.text)) {
                          int difficulty = get_difficulty('Hard');
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => confirmPage(
                                    param: difficulty,
                                    param2: myController.text)),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      )),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  child: const Text('Quit Game'),
                  onPressed: () {
                    // Navigate to the game screen.
                    exit(0);
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text("TOWER DEFENSE!")],
          ),
        )
      ],
    )));
  }
}
