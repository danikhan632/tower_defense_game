import 'package:flame/components.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import 'package:tower_defense/game/game.dart';

late SpriteSheet spriteSheet;

class EnemyManager extends Component with HasGameRef<TowerDefenseGame> {
  // Timer to decide when to spawn next enemy.
  final Timer _timer = Timer(2, repeat: true);

  EnemyManager() {
    _timer.onTick = spawnRandomEnemy;
    

  }
  void spawnRandomEnemy() {
    SpriteSheet spriteSheet = gameRef.getSpriteSheet();

  }
  
  @override
  void update(double dt) {
    _timer.update(dt);
    
  }
}
