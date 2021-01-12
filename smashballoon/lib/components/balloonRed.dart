import 'package:flame/sprite.dart';
import 'package:smashballoon/components/balloons.dart';
import 'package:smashballoon/myGame.dart';

class BalloonRed extends Balloons {
  double get speed => game.tileSize * 0.5;
  BalloonRed(MyGame game, double x, double y) : super(game, x, y) {
    balloonsSprite = List<Sprite>();
    balloonsSprite.add(Sprite('balloon.png'));
    deadSprite = Sprite('explosion.png');
  }
}
