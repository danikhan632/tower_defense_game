import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:tower_defense/game/game.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tower_defense/screens/mainMenu.dart';
import 'package:tower_defense/game/Tower.dart';
import 'package:tower_defense/game/Enemy.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tower Defense',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const MainMenu(),
    ),
  );
}

/**
git clone https://github.com/danikhan632/tower_defense.git
git pull

git init.
git remote add origin URL  
git add .
git commit -m "initial commit"

git commit -m "update"
git push --set-upstream origin master 







 */
