import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';
import 'package:tower_defense/game/Tower.dart';
import 'package:tower_defense/game/Enemy.dart';

// import 'package:tower_defense/game/SideMenu.dart';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';
import 'package:tower_defense/game/Enemy.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Enemy {
  // gun turret in a 2d tower defense game
  double x_pos = 20;
  double y_pos = 310;
  int width = 0;
  int height = 0;
  int damage = 500;
  int HP = 0;
  bool fire = false;
  int? grid_x;
  int? grid_y;
  double direction = -0.785398 * 2;
  double speed = 1;
  int reward = 0;
  double range = 0;
  double fire_rate = 0;
  int damage_state = 0;
  double move_x = 1;
  double move_y = 0.0;
  bool onFire = false;
  SpriteComponent sprite_enemy = new SpriteComponent();

  //upgrades?

  //create an string array of the enemy sprites
  List<Sprite> enemy_sprites = []; //damage states

//EnemgetFirstEnergy

  Enemy(SpriteComponent spr) {
    sprite_enemy = spr;
  }
//test = SpriteComponent()
//       ..sprite = spriteSheet.getSprite(10, 18)
//       ..position = Vector2(600, 500)
//       ..scale = Vector2(1, 1)
//       ..angle = -0.785398 * 2 //pi/2
//       ..size = Vector2(150, 150)
//       ..anchor = Anchor.center;

  SpriteComponent getSprite() {
    return sprite_enemy;
  }

  double getX() {
    return x_pos;
  }

  double getY() {
    return y_pos;
  }

  int getWidth() {
    return width;
  }

  int getHeight() {
    return height;
  }

  bool getFire() {
    return fire;
  }

  void setFire(bool fire_in) {
    fire = fire_in;
    onFire = true;
  }

  bool isOnFire() {
    return onFire;
  }

  int getDamage() {
    return damage;
  }

  void damageEnemy(int damage_in) {
    damage = damage - damage_in;
  }

  int getHP() {
    return HP;
  }

  double getDirection() {
    return direction;
  }

  double getSpeed() {
    return speed;
  }

  int getReward() {
    return reward;
  }

  double getRange() {
    return range;
  }

  double getFireRate() {
    return fire_rate;
  }

  List<Sprite> getEnemySprites() {
    return enemy_sprites;
  }

  void setX(double x) {
    x_pos = x;
  }

  void setY(double y) {
    y_pos = y;
  }

  void setWidth(int w) {
    width = w;
  }

  void setHeight(int h) {
    height = h;
  }

  void setDamage(int d) {
    damage = d;
  }

  void setHP(int h) {
    HP = h;
  }

  double getPrevMoveX() {
    return move_x;
  }

  double getPrevMoveY() {
    return move_y;
  }

  void setPrevMoveX(double d) {
    move_x = d;
  }

  void setPrevMoveY(double d) {
    move_y = d;
  }

  void setDirection(double d) {
    direction = d;
  }

  void setSpeed(double s) {
    speed = s;
  }

  void setReward(int r) {
    reward = r;
  }

  void setRange(double r) {
    range = r;
  }

  void setFireRate(double f) {
    fire_rate = f;
  }

  // void setSprite(String s){sprite_enemy = s;}
  void setEnemySprites(List<Sprite> s) {
    enemy_sprites = s;
  }

  void setDamageState(int d) {
    damage_state = d;
  }

  int getDamageState() {
    return damage_state;
  }

  Vector2 updatePosition(double dt) {
    Vector2 new_pos = new Vector2(x_pos, y_pos);
    new_pos.x += (speed * dt) * cos(direction);
    new_pos.y += (speed * dt) * sin(direction);
    return new_pos;
  }

  Vector3 turnCheck(SpriteComponent spr, Vector2 spd, double width,
      double height, double vel) {
    if (spr.position.x > (width * 0.25) &&
        spr.position.y > (height * 0.19) &&
        spr.angle == 0) {
      //print('1');
      return Vector3(0, vel, 1.58);
    } else if (spr.position.y > (height * 0.8) && spr.angle == 1.58) {
      //print('2');
      //print(height);
      return Vector3(vel, 0, 0.001);
    } else if (spr.position.x > (width * 0.46) && spr.angle == 0.001) {
      //print('3');
      return Vector3(0, -vel, -1.58);
    } else if (spr.position.y < (height * 0.19) && spr.angle == -1.58) {
      //print('4');
      return Vector3(vel, 0.0, 0);
    } else if (spr.position.x > (width * 0.65) && spr.angle == 0) {
      // print('5');
      return Vector3(0, vel, 1.581);
    } else if (spr.position.y > (height * 0.64) && spr.angle == 1.581) {
      //print('6');
      return Vector3(vel, 0, 0.0001);
    }
    return Vector3(spd.x * vel, spd.y * vel, spr.angle);
  }

  @override
  void render(Canvas canvas) {}
  void update(double dt) {
    //enemy.update(dt);
    sprite_enemy..position = updatePosition(dt);
  }
}
