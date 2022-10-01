import 'package:flame/components.dart';

import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

import 'package:path_provider/path_provider.dart';

import 'package:tower_defense/game/Tower.dart';
import 'package:tower_defense/game/Enemy.dart';
// import 'package:tower_defense/game/SideMenu.dart';
import 'dart:math';

class Tower extends PositionComponent {
  // gun turret in a 2d tower defense game
  double x_pos = 0;
  double y_pos = 0;
  bool audio = false;
  int damage = -3;
  double range = 0;
  double fire_rate = 0;
  double direction = 0;
  int cost = 0;
  int spr_num = 0;
  bool fire = false;
  //upgrades?
  String sprite_bottom = "";
  String sprite_top = "";
  String sprite_muzzle_flash = "";
  String gunfire_audio = "";
  SpriteComponent sprite = new SpriteComponent();

  Tower(SpriteComponent spr, int spr_Num) {
    sprite = spr;
    x_pos = sprite.x;
    y_pos = sprite.y;
    spr_num = spr_Num;
  }
  SpriteComponent getSprite() {
    return sprite;
  }

  int getSpriteNum() {
    return spr_num;
  }

  //end drag
  int getCost() {
    return cost;
  }

  int getDamage() {
    return damage;
  }

  double getRange() {
    return range;
  }

  double getFireRate() {
    return fire_rate;
  }

  double getDirection() {
    return direction;
  }

  bool isAudio() {
    return audio;
  }

  void setAudio(bool a) {
    audio = a;
  }

  double getX() {
    return x_pos;
  }

  double getY() {
    return y_pos;
  }

  bool getFire() {
    return fire;
  }

  void setFire(bool fire_in) {
    fire = fire_in;
  }

  String getSpriteBottom() {
    return sprite_bottom;
  }

  String getSpriteTop() {
    return sprite_top;
  }

  String getSpriteMuzzleFlash() {
    return sprite_muzzle_flash;
  }

  String getGunfireAudio() {
    return gunfire_audio;
  }

  void setX(double x) {
    x_pos = x;
  }

  void setY(double y) {
    y_pos = y;
  }

  void setDirection(double d) {
    direction = d;
  }

  void setRange(double r) {
    range = r;
  }

  void setFireRate(double f) {
    fire_rate = f;
  }

  void setDamage(int d) {
    damage = d;
  }

  void setCost(int c) {
    cost = c;
  }

  void setSpriteBottom(String s) {
    sprite_bottom = s;
  }

  void setSpriteTop(String s) {
    sprite_top = s;
  }

  void setSpriteMuzzleFlash(String s) {
    sprite_muzzle_flash = s;
  }

  void setGunfireAudio(String s) {
    gunfire_audio = s;
  }

// Enemy getTarget(List<Object> enemyList, Tower tower){
//     //find the closest enemy
//     //return the enemy
//     // if(enemyList.length == 0){
//     //   return Enemy(0,0,0,0,0,0,0,0,0,0,0,0);
//     // }
//     for(var i = enemyList.length - 1; i >= 0; i--){
//       if(getDistance(enemyList[i],tower) <= range){
//         return enemyList[i];
//       }

//     }
//   }
  double angleUpdate(Vector2 enemy) {
    //find the distance between the enemy and the player
    //return the distance
    double angle = tan((enemy.y - y_pos) / (enemy.x - x_pos)) + (1.5 * pi);
    if (enemy.x > x_pos) {
      angle += pi;
    }
    return angle;
  }

  bool isPressed(Vector2 tap, Tower tower) {
    //check if the tower is pressed
    //return true if pressed
    if (tap.x >= tower.getX() - tower.getSprite().width / 2 &&
        tap.x <= tower.getX() + tower.getSprite().width / 2 &&
        tap.y >= tower.getY() - tower.getSprite().height / 2 &&
        tap.y <= tower.getY() + tower.getSprite().height / 2) {
      print("pressed");
      return true;
    }
    return false;
  }
}
