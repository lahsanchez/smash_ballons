import 'dart:ui';
import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:smashballoon/components/balloons.dart';
import 'package:smashballoon/components/fundo.dart';
import 'package:smashballoon/components/balloonRed.dart';
import 'package:smashballoon/controllers/balloonSpawner.dart';
import 'package:smashballoon/view.dart';
import 'package:smashballoon/views/home_view.dart';
import 'package:smashballoon/components/startbutton.dart';

class MyGame extends Game {
  Size screenSize;
  double tileSize;
  List<Balloons> flies;
  Random rnd;

  Fundo fundo;

  View activeView = View.home;

  HomeView homeView;

  StartButton startButton;

  BalloonSpawner spawner;

  MyGame() {
    initialize();
  }

  void initialize() async {
    flies = List<Balloons>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());

    fundo = Fundo(this);

    homeView = HomeView(this);

    startButton = StartButton(this);

    spawner = BalloonSpawner(this);
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = screenSize.height;
    flies.add(BalloonRed(this, x, y));
  }

  void render(Canvas canvas) {
    fundo.render(canvas);

    if (activeView == View.home) homeView.render(canvas);

    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
    }

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
    bool isHandled = false;
    bool didHitABalloons = false;
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        isHandled = true;
        didHitABalloons = true;
      }
    }
    if (!isHandled) {
      flies.forEach((Balloons balloons) {
        if (balloons.balloonRect.contains(d.globalPosition)) {
          balloons.onTapDown();
          isHandled = true;
          didHitABalloons = true;
        }
      });
    }
    if (activeView == View.playing && !didHitABalloons) {
      activeView = View.lost;
    }
  }
}
