import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:smashballoon/myGame.dart';
import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';

void main() {
  Util flameUtil = Util();
  WidgetsFlutterBinding.ensureInitialized();

  Flame.images.loadAll(<String>[
    'bg/fundo.png',
    'balloon.png',
  ]);

  MyGame game = MyGame();
  runApp(game.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  // ignore: deprecated_member_use
  flameUtil.addGestureRecognizer(tapper);
}
