// import 'dart:html';
// import 'dart:js';
import 'dart:ui' hide TextStyle;

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:tower_defense/game/AudioManager.dart';
import 'package:flame/sprite.dart';
import 'package:tower_defense/game/Enemy.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:tower_defense/game/SideMenu.dart';
import 'package:tower_defense/game/Tower.dart';
import '../game/game.dart';
import '../widgets/overlays/pause_button.dart';
import '../widgets/overlays/pause_menu.dart';

import 'package:tower_defense/game/grid.dart';

//1.570 is south/d
//6.283 / 0 is east
//3.14 is west
//4.712 north
final style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 15,
    fontFamily: "Retro");
// foreground: Paint()
//   ..style = PaintingStyle.stroke
//   ..strokeWidth = 6
//   ..color = Colors.lightBlue);

final regular = TextPaint(style: style);

final largeStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 30,
  fontFamily: "Retro",
);

final large = (TextPaint(style: largeStyle));

final fillStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    fontFamily: "Retro",
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.01
      ..color = Colors.green);

final fillRegular = TextPaint(style: fillStyle);

final fillLargeStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30,
    fontFamily: "Retro",
    foreground: Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..color = Colors.blueGrey[100]!);

final fillLarge = (TextPaint(style: fillLargeStyle));

class TowerDefenseGame extends FlameGame with HasTappables {
  static SpriteComponent test = new SpriteComponent();
  static TextComponent money = new TextComponent();
  static TextComponent moneyBack = new TextComponent();
  static TextComponent monumentHealth = new TextComponent();
  static TextComponent monumentHealthBack = new TextComponent();
  static StartButton startButton = new StartButton();
  static GunTowerButton gunTowerButton = new GunTowerButton();
  static GunTowerButton gunTowerButton2 = new GunTowerButton();
  static GunTowerButton gunTowerButton3 = new GunTowerButton();
  static final Vector2 buttonSize = Vector2(150.0, 75.0);
  static int enemiesKilled = 0;
  static int tower_dmg = 10;
  static bool final_lvl = false;
  static String menu_str = "";
  static bool placeTower = false;
  static bool buyTower = false;
  static int tower_sel = 0;
  static int gun_tower_cost = 0;
  static int missile_tower_cost = 0;
  static int laser_tower_cost = 0;
  static List<Enemy> enemyList = [];
  static List<Tower> towerList = [];
  static List<Object> bulletList = [];
  static List<int> levelList = [5, 10];
  static int hardFinal = 500;
  static int mediumFinal = 400;
  static int easyFinal = 300;
  static int easyUpgradeHit = 5;
  static int mediumUpgradeHit = 10;
  static int hardUpgradeHit = 20;
  static int easyTowerUpgradeRange = 300;
  static int mediumTowerUpgradeRange = 200;
  static int hardTowerUpgradeRange = 100;
  static int easyTowerUpgradePrice = 100;
  static int mediumTowerUpgradePrice = 200;
  static int hardTowerUpgradePrice = 300;

  static bool combat = false;
  static int wallet = 1;
  static int initMoney = 1;
  static int health = 0;
  static double width = 0.0;
  static double height = 0.0;
  static SpriteComponent? test2;
  static late SpriteSheet spriteSheet;
  static late SpriteComponent fire;
  static TextComponent menu_text = new TextComponent();
  static TextComponent menu_textBack = new TextComponent();

  Future<void> onLoad() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    // AudioManager.instance.startBgm('vamp.mp3');
    Grid grid = new Grid(width, height);

    //  camera.viewport = FixedResolutionViewport(Vector2(1280, 720));

    SpriteComponent background = SpriteComponent()
      ..sprite = await Sprite.load('game_map.png')
      ..size = size;
    add(background);

    final imageInstance = await images.load('sprite_sheet.png');
    spriteSheet = SpriteSheet.fromColumnsAndRows(
        image: imageInstance, columns: 23, rows: 13);

    SpriteComponent test = SpriteComponent()
      ..sprite = spriteSheet.getSprite(10, 15)
      ..position = Vector2(width * 0.01, height * 0.46)
      ..scale = Vector2(1, 1)
      ..angle = 0 //pi/2
      ..size = Vector2(height * 0.23, height * 0.23)
      ..anchor = Anchor.center;
    test2 = test;
    enemyList.add(new Enemy(test));

    SpriteComponent monument = SpriteComponent()
      ..sprite = spriteSheet.getSprite(11, 17)
      ..position = Vector2(width * 0.83, height * 0.64)
      ..scale = Vector2(1, 1)
      ..angle = 3.14 //pi/2
      ..size = Vector2(150, 150)
      ..anchor = Anchor.center;
    add(monument);
    fire = SpriteComponent()
      ..sprite = spriteSheet.getSprite(12, 20)
      ..position = Vector2(0, 0)
      ..scale = Vector2(1, 1)
      ..angle = 0 //pi/2
      ..size = Vector2(150, 150)
      ..anchor = Anchor.center;

    moneyBack = (TextComponent(
      text: ("\$" + wallet.toString()),
      position: Vector2(width * 0.01, height * 0.01),
      textRenderer: fillLarge,
    ));
    add(moneyBack);

    money = TextComponent(
      text: ("\$" + wallet.toString()),
      position: Vector2(width * 0.01, height * 0.01),
      textRenderer: large,
    );
    add(money);

    for (int i = 0; i < enemyList.length; i++) {
      add(enemyList[i].getSprite());
    }
    for (int i = 0; i < towerList.length; i++) {
      add(towerList[i].getSprite());
    }
    towerList.add(Tower(monument, -1));

    monumentHealthBack = (TextComponent(
        text: health.toString() + 'hp',
        position: Vector2(width * 0.78, height * 0.74),
        textRenderer: fillLarge));
    add(monumentHealthBack);

    monumentHealth = TextComponent(
        text: health.toString() + 'hp',
        position: Vector2(width * 0.78, height * 0.74),
        textRenderer: large);
    add(monumentHealth);

    menu_str = "Menu\nGun Tower: \$" +
        (5000 ~/ initMoney).toString() +
        "\nMissile Tower: \$" +
        (10000 ~/ initMoney).toString() +
        "\nLaser Tower: \$" +
        (15000 ~/ initMoney).toString() +
        "\n";
    menu_text = (TextComponent(
      textRenderer: regular,
    )
      ..text = menu_str
      ..anchor = Anchor.bottomRight
      ..x = width
      ..y = height);
    add(menu_text);

    menu_textBack = (TextComponent(
      textRenderer: fillRegular,
    )
      ..anchor = Anchor.bottomRight
      ..text = menu_str
      ..x = width
      ..y = height);
    add(menu_textBack);
    // menu_text
    //   ..text = menu_str
    //   ..position = Vector2(width * 0.85, height * .85)
    //   ..scale = Vector2(0.8, 0.8);

    // add(menu_text);

    startButton
      ..sprite = await loadSprite('startButton.png')
      ..size = buttonSize
      ..position =
          Vector2(size[0] - buttonSize[0] - 10, size[1] - buttonSize[1] - 120);

    add(startButton);

    gunTowerButton
      ..sprite = TowerDefenseGame.spriteSheet.getSprite(10, 19)
      ..position = Vector2(size[0] - 100, size[1] - 650)
      ..scale = Vector2(0.6, 0.6)
      ..angle = 4.71 //pi/2
      ..size = Vector2(height * 0.23, height * 0.23)
      ..anchor = Anchor.center;
    add(gunTowerButton);

    gunTowerButton2
      ..sprite = TowerDefenseGame.spriteSheet.getSprite(8, 20)
      ..position = Vector2(size[0] - 100, size[1] - 525)
      ..scale = Vector2(0.6, 0.6)
      ..angle = 4.71 //pi/2
      ..size = Vector2(height * 0.23, height * 0.23)
      ..anchor = Anchor.center;
    add(gunTowerButton2);

    gunTowerButton3
      ..sprite = TowerDefenseGame.spriteSheet.getSprite(10, 20)
      ..position = Vector2(size[0] - 100, size[1] - 400)
      ..scale = Vector2(0.6, 0.6)
      ..angle = 4.71 //pi/2
      ..size = Vector2(height * 0.23, height * 0.23)
      ..anchor = Anchor.center;
    add(gunTowerButton3);
  }

  void main() {}
  TowerDefenseGame(int number, double width_in, double height_in) {
    wallet = number;
    initMoney = 2 * number;
    health = (100 - 0.5 * number).toInt();
    width = width_in;
    height = height_in;
    gun_tower_cost = 5000 ~/ initMoney;
    missile_tower_cost = 10000 ~/ initMoney;
    laser_tower_cost = 15000 ~/ initMoney;
  }
//for unit testing only
  List<Tower> getTowers() {
    return towerList;
  }

  int getEnemyDamage() {
    return initMoney ~/ 10;
  }

  List<Enemy> getEnemies() {
    return enemyList;
  }

  int getWallet() {
    return wallet;
  }

  int getHealth() {
    return health;
  }

  List<Enemy> getEnemyList() {
    return enemyList;
  }

  void addEnemy() {
    SpriteComponent test = SpriteComponent()
      ..sprite = spriteSheet.getSprite(10, 15)
      ..position = Vector2(width * 0.01, height * 0.46)
      ..scale = Vector2(1, 1)
      ..angle = 0 //pi/2
      ..size = Vector2(height * 0.23, height * 0.23)
      ..anchor = Anchor.center;
    enemyList.add(new Enemy(test));
  }

  void removeAllEnemies() {
    enemyList.clear();
  }

  void removeAllTowers() {
    towerList.clear();
  }

  SpriteSheet getSpriteSheet() {
    return spriteSheet;
  }

  bool getCombat() {
    return combat;
  }

  void removeLastEnemy() {
    enemyList.remove(enemyList.length - 1);
  }

  void removeFirstEnemy() {
    enemyList.remove(0);
  }

  void removeLastTower() {
    towerList.remove(towerList.length - 1);
  }

  void removeFirstTower() {
    towerList.remove(0);
  }

  int getEnemyCount() {
    return enemyList.length;
  }

  int enemy_monument_hit() {
    health -= 10;
    if (health <= 0) {
      health = 0;
    }
    return health;
  }

  bool game_over(int health) {
    if (health <= 0) {
      combat = false;
      return true;
    }
    return false;
  }

  int getGunTowerCost() {
    return gun_tower_cost;
  }

  int getTowerDamage() {
    int damage = 0;
    for (Tower tower in getTowers()) {
      damage += tower.damage;
    }
    return damage;
  }

  bool isEnemyHit() {
    Enemy enemy = getEnemies().first;
    if (enemy.isOnFire()) {
      return true;
    } else {
      return false;
    }
  }

  int getInitMoney() {
    return initMoney;
  }

  bool towerDetection(Vector2 pos) {
    for (int i = 0; i < towerList.length; i++) {
      if (towerList[i].getSprite().position.x > 20) {
        return true;
      }
    }
    return false;
  }

  int getMissileTowerCost() {
    return missile_tower_cost;
  }

  int getFinalBossHealthHard() {
    return hardFinal;
  }

  int getFinalBossHealthMedium() {
    return mediumFinal;
  }

  int getFinalBossHealthEasy() {
    return easyFinal;
  }

  int getEasyUpgradeHit() {
    return easyUpgradeHit;
  }

  int getMediumUpgradeHit() {
    return mediumUpgradeHit;
  }

  int getHardUpgradeHit() {
    return hardUpgradeHit;
  }

  int getLaserTowerCost() {
    return laser_tower_cost;
  }

  int getEasyTowerUpgradeRange() {
    return easyTowerUpgradeRange;
  }

  int getMediumTowerUpgradeRange() {
    return mediumTowerUpgradeRange;
  }

  int getHardTowerUpgradeRange() {
    return hardTowerUpgradeRange;
  }

  int getEasyTowerUpgradePrice() {
    return easyTowerUpgradePrice;
  }

  int getMediumTowerUpgradePrice() {
    return mediumTowerUpgradePrice;
  }

  int getHardTowerUpgradePrice() {
    return hardTowerUpgradePrice;
  }

  // for testing only

  double move_x = 1;
  double move_y = 0.0;

  @override
  void update(double dt) {
    super.update(dt);
    if (combat == true) {
      if (health <= 0) {
        combat = false;
        gameOver();
      } else if (enemiesKilled == 5 || final_lvl == true) {
        finalBoss();
      }
      towerCheck();
      if (enemiesKilled > 6) {
        combat = false;
        gameOver();
      }

      for (int i = 0; i < enemyList.length; i++) {
        if (enemyList[i].getSprite().position.x > width * 0.82 &&
            final_lvl == false) {
          resetEnemy(i);
        }
        Vector3 pos = enemyList[i].turnCheck(
            enemyList[i].getSprite(),
            Vector2(enemyList[i].getPrevMoveX(), enemyList[i].getPrevMoveY()),
            width,
            height,
            enemyList[i].getSpeed());
        enemyList[i].setPrevMoveX(pos.x);
        enemyList[i].setPrevMoveY(pos.y);
        enemyList[i].getSprite().position = Vector2(
          enemyList[i].getSprite().position.x + pos.x,
          enemyList[i].getSprite().position.y + pos.y,
        );
        enemyList[i].getSprite().angle = pos.z;
      }
    }
  }

  void towerCheck() {
    for (int i = 0; i < towerList.length; i++) {
      for (int j = 0; j < enemyList.length; j++) {
        double x_dist = (enemyList[j].getSprite().position.x -
                towerList[i].getSprite().position.x)
            .abs();
        double y_dist = (enemyList[j].getSprite().position.y -
                towerList[i].getSprite().position.y)
            .abs();

        if (x_dist < (width / 7) && y_dist < (height / 6)) {
          //do someothing
          double tempNum =
              towerList[i].angleUpdate(enemyList[j].getSprite().position);
          print(tempNum);

          towerList[i].getSprite().angle = tempNum;
          if (towerList[i].getSpriteNum() == 2) {
            AudioManager.instance.playSfx('laser.mp3');
          }
          if (towerList[i].getSpriteNum() == 0) {
            AudioManager.instance.playSfx('gun.mp3');
          }

          fire..position = enemyList[j].getSprite().position;
          add(fire);
          if (enemyList[j].getDamage() <= 0) {
            resetEnemy(j);
          }

          enemyList[j].damageEnemy(-towerList[i].getDamage());
        } else {
          remove(fire);
        }
      }
    }
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    upgradeCheck(info.eventPosition.game);
    if ((info.eventPosition.game.x >= width * 0.85) && combat) {
      buyButtons(info.eventPosition.game);
    } else if (info.eventPosition.game.x >= width * 0.85) {
      menu_text.text = menu_str + "Combat has not started!";
      menu_textBack.text = menu_str + "Combat has not started!";
    }
    bool isOnpath = onPath(info.eventPosition.game);

    if (!isOnpath && buyTower) {
      if (tower_sel == 1) {
        addGunTower(info, 10, 19);
      } else if (tower_sel == 2) {
        addGunTower(info, 8, 20);
      } else if (tower_sel == 3) {
        addGunTower(info, 10, 20);
      }
    } else if (isOnpath && buyTower) {
      menu_text.text = menu_str + "Place elsewhere";
      menu_textBack.text = menu_str + "Place elsewhere";
    }
  }

  static bool onPath(Vector2 pos) {
    List<Vector2> h_boxes = <Vector2>[
      Vector2(0, width * 0.539), //blackbox
      Vector2(width * 0.2, width * 0.3), //redbox
      Vector2(width * 0.3, width * 0.5), // blue blueBox
      Vector2(width * 0.4, width * 0.5), //pinkBox
      Vector2(width * 0.4, width * 0.7), //brownBox
      Vector2(width * 0.6, width * 0.7), //yellowBox
      Vector2(width * 0.7, width * 0.85), //grayBox
    ];
    List<Vector2> v_boxes = <Vector2>[
      Vector2(height * 0.352, height * 0.552), //blackbox
      Vector2(height * 0.56, height * 0.904), //redbox
      Vector2(height * 0.72, height * 0.904), // blue blueBox
      Vector2(height * 0.27, height * 0.72), //pinkBox
      Vector2(height * 0.1, height * 0.27), //brownBox
      Vector2(height * 0.27, height * 0.72), //yellowBox
      Vector2(height * 0.55, height * 0.72), //grayBox

      // [1333.3333333333333,800.0]
    ];

    //print(pos);
    if (pos.x >= width * 0.85) {
      return true;
    }
    for (int i = 0; i < 7; i++) {
      if (h_boxes[i].x < pos.x &&
          pos.x < h_boxes[i].y &&
          v_boxes[i].x < pos.y &&
          pos.y < v_boxes[i].y) {
        return true;
      }
    }
    return false;
  }

  static void buyButtons(Vector2 pos) {
    if (pos.y >= height * 0.13 && pos.y <= height * 0.22) {
      if (wallet >= (5000 / initMoney)) {
        buyTower = true;
        tower_sel = 1;
        wallet -= 5000 ~/ initMoney;
        money.text = "\$" + wallet.toInt().toString();
        moneyBack.text = "\$" + wallet.toInt().toString();
        menu_text.text = menu_str + "Place Gun Tower";
        menu_textBack.text = menu_str + "Place Gun Tower";
      } else {
        menu_text.text = menu_str + "Insufficient Funds";
        menu_textBack.text = menu_str + "Insufficient Funds";
      }
    } else if (pos.y >= height * 0.29 && pos.y <= height * 0.39) {
      if (wallet >= (10000 / initMoney)) {
        buyTower = true;
        tower_sel = 2;
        wallet -= 10000 ~/ initMoney;
        money.text = "\$" + wallet.toInt().toString();
        moneyBack.text = "\$" + wallet.toInt().toString();
        menu_text.text = menu_str + "Place Missile Tower";
        menu_textBack.text = menu_str + "Place Missile Tower";
      } else {
        menu_text.text = menu_str + "Insufficient Funds";
        menu_textBack.text = menu_str + "Insufficient Funds";
      }
    } else if (pos.y >= height * 0.45 && pos.y <= height * 0.55) {
      if (wallet >= (15000 / initMoney)) {
        buyTower = true;
        tower_sel = 3;
        wallet -= 15000 ~/ initMoney;
        money.text = "\$" + wallet.toInt().toString();
        moneyBack.text = "\$" + wallet.toInt().toString();
        menu_text.text = menu_str + "Place Laser Tower";
        menu_textBack.text = menu_str + "Place Laser Tower";
      } else {
        menu_text.text = menu_str + "Insufficient Funds";
        menu_textBack.text = menu_str + "Insufficient Funds";
      }
    }
  }

  void addGunTower(TapDownInfo info, int x_sheet, int y_sheet) async {
    print("addGunTower");
    for (int i = 0; i < towerList.length; i++) {
      if ((towerList[i].getSprite().position.x - info.eventPosition.game.x)
              .abs() <
          80) {
        if ((towerList[i].getSprite().position.y - info.eventPosition.game.y)
                .abs() <
            80) {
          menu_text.text = menu_str + "Place elsewhere";
          menu_textBack.text = menu_str + "Place elsewhere";
          return;
        }
      }
    }
    SpriteComponent tower = SpriteComponent()
      ..sprite = spriteSheet.getSprite(x_sheet, y_sheet)
      ..position = Vector2(info.eventPosition.game.x, info.eventPosition.game.y)
      ..scale = Vector2(0.6, 0.6)
      ..angle = 4.71 //pi/2
      ..size = Vector2(height * 0.23, height * 0.23)
      ..anchor = Anchor.center;
    towerList.add(Tower(tower, y_sheet - 15));
    add(tower);
    buyTower = false;
    tower_sel = 0;
    menu_text.text = menu_str;
    menu_textBack.text = menu_str;
  }

  void resetEnemy(int index) {
    //kill screen

    if (enemyList[index].getSprite().position.x > width * 0.82) {
      health -= tower_dmg;
      if (health == 0) {
        combat = false;
        menu_text.text = "Game Over";
      }
      monumentHealth.text = health.toString() + "hp";
      monumentHealthBack.text = health.toString() + "hp";
    } else {
      wallet += 15;
      money.text = "\$" + wallet.toInt().toString();
    }

    remove(enemyList[index].getSprite());
    enemyList.removeAt(index);
    enemyList.clear();
    move_x = 1;
    move_y = 0.0;
    int enemy_choice = 0;
    if (enemiesKilled % 3 == 0) {
      enemy_choice = 2;
    } else if (enemiesKilled % 3 == 1) {
      enemy_choice = 1;
    }
    SpriteComponent temp = SpriteComponent()
      ..sprite = spriteSheet.getSprite(10, 15 + enemy_choice)
      ..position = Vector2(width * 0.01, height * 0.46)
      ..scale = Vector2(1, 1)
      ..angle = 0 //pi/2
      ..size = Vector2(height * 0.23, height * 0.23)
      ..anchor = Anchor.center;
    Enemy enemyTemp = new Enemy(temp);
    enemiesKilled++;
    enemyTemp.setDamage(500 + 120 * enemiesKilled);
    enemyTemp.setSpeed((1) + 0.003 * enemiesKilled);

    enemyList.add(enemyTemp);
    add(enemyTemp.getSprite());
  }

  Enemy debug_get_enemy() {
    return enemyList[0];
  }

  void upgradeCheck(Vector2 pos) {
    for (int i = 0; i < towerList.length; i++) {
      if ((towerList[i].getSprite().position.x - pos.x).abs() < 80) {
        if ((towerList[i].getSprite().position.y - pos.y).abs() < 80) {
          if (wallet >= (5000 / initMoney)) {
            wallet -= 2500 ~/ initMoney;
            money.text = "\$" + wallet.toInt().toString();
            moneyBack.text = "\$" + wallet.toInt().toString();
            tower_dmg += 10;
          }
        }
      }
    }
  }

  void finalBoss() {
    print("finalBoss\n" + enemiesKilled.toString() + "\n");
    if (enemyList[0].getSprite().position.x > width * 0.82 &&
        final_lvl == true) {
      health = 0;
      combat = false;
      menu_text.text = "You Lose";
      gameOver();
    } else if (final_lvl == false) {
      enemyList.clear();
      SpriteComponent temp = SpriteComponent()
        ..sprite = spriteSheet.getSprite(10, 17)
        ..position = Vector2(width * 0.01, height * 0.46)
        ..scale = Vector2(2, 2)
        ..angle = 0 //pi/2
        ..size = Vector2(height * 0.23, height * 0.23)
        ..anchor = Anchor.center;
      Enemy enemyTemp = new Enemy(temp);
      enemiesKilled++;
      enemyTemp.setDamage(500 + 180 * enemiesKilled);
      enemyTemp.setSpeed((1) + 0.005 * enemiesKilled);

      enemyList.add(enemyTemp);
      add(enemyTemp.getSprite());
      final_lvl = true;
    }
  }
//   I/flutter (29042): game over
// I/flutter (29042): Enemies Killed: 7
// I/flutter (29042): Money: 103
// I/flutter (29042): Monument Health: 50
// I/flutter (29042): Towers Placed: 2

// I/flutter (29042): game over
// I/flutter (29042): Enemies Killed: 6
// I/flutter (29042): Money: 88
// I/flutter (29042): Monument Health: 0
// I/flutter (29042): Towers Placed: 2

  void reset() {
    combat = false;
    for (int i = 0; i < enemyList.length; i++) {
      remove(enemyList[i].getSprite());
    }
    for (int i = 0; i < towerList.length; i++) {
      remove(towerList[i].getSprite());
    }
    enemyList.clear();
    towerList.clear();

    // TowerDefenseGame(number, width_in, height_in)
  }

  void gameOver() {
    print(" \n\n\n\n\ ");
    print("game over");
    print("Enemies Killed: " + enemiesKilled.toString());
    print("Money: " + wallet.toString());
    print("Monument Health: " + health.toString());
    print("Towers Placed: " + (towerList.length - 1).toString());
    print(" \n\n\n\n\ ");
  }

  @override
  void onTapCancel(int pointerId);
}

class StartButton extends SpriteComponent with Tappable {
  @override
  bool onTapDown(TapDownInfo info) {
    print("start");
    TowerDefenseGame.combat = true;
    return true;
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    pauseEngine();
  }

  void upgradeCheck() {
    print("upgrade");
  }

  void pauseEngine() {}
}

class GunTowerButton extends SpriteComponent with Tappable {
  // @override
  // bool onTapDown(TapDownInfo info) {
  //   if (info.eventPosition.game.x >= width * 0.85) {
  //     TowerDefenseGame.buyButtons(info.eventPosition.game);
  //   }
  //   bool isOnpath = TowerDefenseGame.onPath(info.eventPosition.game);
  // }
  //   if (!isOnpath && TowerDefenseGame.buyTower) {
  //     if (TowerDefenseGame.tower_sel == 1) {
  //       addGunTower(info, 10, 19);
  //     } else if (TowerDefenseGame.tower_sel == 2) {
  //       addGunTower(info, 8, 20);
  //     } else if (TowerDefenseGame.tower_sel == 3) {
  //       addGunTower(info, 10, 20);
  //     }
  //   } else if (isOnpath && TowerDefenseGame.buyTower) {
  //     TowerDefenseGame.menu_text
  //       ..text = TowerDefenseGame.menu_str + "Place elsewhere";
  //   }
  //   return true;
  // }

  // void addGunTower(TapDownInfo info, int x_sheet, int y_sheet) async {
  //   print("addGunTower");
  //   for (int i = 0; i < TowerDefenseGame.towerList.length; i++) {
  //     if ((TowerDefenseGame.towerList[i].getSprite().position.x -
  //                 info.eventPosition.game.x)
  //             .abs() <
  //         80) {
  //       if ((TowerDefenseGame.towerList[i].getSprite().position.y -
  //                   info.eventPosition.game.y)
  //               .abs() <
  //           80) {
  //         TowerDefenseGame.menu_text
  //           ..text = TowerDefenseGame.menu_str + "Place elsewhere";
  //         return;
  //       }
  //     }
  //   }
  //   SpriteComponent tower = SpriteComponent()
  //     ..sprite = TowerDefenseGame.spriteSheet.getSprite(x_sheet, y_sheet)
  //     ..position = Vector2(info.eventPosition.game.x, info.eventPosition.game.y)
  //     ..scale = Vector2(0.6, 0.6)
  //     ..angle = 4.71 //pi/2
  //     ..size = Vector2(height * 0.23, height * 0.23)
  //     ..anchor = Anchor.center;
  //   TowerDefenseGame.towerList.add(Tower(tower));
  //   add(tower);
  //   TowerDefenseGame.buyTower = false;
  //   TowerDefenseGame.tower_sel = 0;
  //   TowerDefenseGame.menu_text..text = TowerDefenseGame.menu_str;
}
