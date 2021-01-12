import 'dart:ui';
import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:smashballoon/components/balloons.dart';
import 'package:smashballoon/components/fundo.dart';
import 'package:smashballoon/components/balloonRed.dart';
import 'package:smashballoon/controllers/balloonSpawner.dart';

class MyGame extends Game {
  Size screenSize;
  double tileSize;
  List<Balloons> flies;
  Random rnd;

  Fundo fundo;

  BalloonSpawner spawner;

  MyGame() {
    initialize();
  }

  void initialize() async {
    flies = List<Balloons>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());

    fundo = Fundo(this);

    spawner = BalloonSpawner(this);
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = screenSize.height;
    flies.add(BalloonRed(this, x, y));
  }

  void render(Canvas canvas) {
    fundo.render(canvas);

    flies.forEach((Balloons balloons) => balloons.render(canvas));
  }

  void update(double t) {
    flies.forEach((Balloons balloons) => balloons.update(t));
    flies.removeWhere((Balloons balloons) => balloons.isOffScreen);
    spawner.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    flies.forEach((Balloons balloons) {
      if (balloons.balloonRect.contains(d.globalPosition)) {
        balloons.onTapDown();
      }
    });
  }
}
