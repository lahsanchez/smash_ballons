import 'dart:ui';
import 'package:smashballoon/myGame.dart';
import 'package:flame/sprite.dart';

class Balloons {
  final MyGame game;
  List<Sprite> balloonsSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  Rect balloonRect;
  bool isDead = false;
  bool isOffScreen = false;

  double get speed => game.tileSize * 0.5;
  Offset targetLocation;

  void setTargetLocation() {
    double x = 0;
    double y = 0.5;
    targetLocation = Offset(x, y);
  }

  Balloons(this.game, double x, double y) {
    balloonRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    setTargetLocation();
  }

  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(c, balloonRect.inflate(2));
    } else {
      balloonsSprite[flyingSpriteIndex.toInt()]
          .renderRect(c, balloonRect.inflate(2));
    }
  }

  void update(double t) {
    if (isDead) {
      // make the fly fall
      balloonRect = balloonRect.translate(0, game.tileSize * 12 * t);
      if (balloonRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    }

    double stepDistance = speed * t;
    Offset toTarget = targetLocation - Offset(0, balloonRect.bottom);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget =
          Offset.fromDirection(toTarget.direction, stepDistance);
      balloonRect = balloonRect.shift(stepToTarget);
    } else {
      balloonRect = balloonRect.shift(toTarget);
      setTargetLocation();
    }
  }

  void onTapDown() {
    isDead = true;
  }
}
