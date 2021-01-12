import 'package:smashballoon/myGame.dart';
import 'package:smashballoon/components/balloons.dart';

class BalloonSpawner {
  final MyGame game;
  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 250;
  final int intervalChange = 8;
  final int maxFliesOnScreen = 100;
  int currentInterval;
  int nextSpawn;

  BalloonSpawner(this.game) {
    start();
    game.spawnFly();
  }

  get flies => null;

  void start() {
    killAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAll() {
    game.flies.forEach((Balloons balloons) => balloons.isDead = true);
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    int livingFlies = 0;
    game.flies.forEach((Balloons balloons) {
      if (!balloons.isDead) livingFlies += 1;
    });

    if (nowTimestamp >= nextSpawn && livingFlies < maxFliesOnScreen) {
      game.spawnFly();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }
}
