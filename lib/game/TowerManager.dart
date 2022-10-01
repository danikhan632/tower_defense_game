import 'package:flame/components.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:tower_defense/game/Tower.dart';
import 'package:tower_defense/game/game.dart';

late SpriteSheet spriteSheet;
List<Tower> towerList = [];

class TowerManager extends Component with HasGameRef<TowerDefenseGame> {
  final Timer _timer = Timer(2, repeat: true);

  TowerManager() {}
  void addTowertoManager(Tower tower) {
    towerList.add(tower);
  }

  @override
  void update(double dt) {
    _timer.update(dt);
  }

  void enemyCheck() {
    for (int i = 0; i < towerList.length; i++) {}
  }
}
