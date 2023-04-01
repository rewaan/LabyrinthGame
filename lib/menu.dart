import 'dart:math';

import 'package:flutter/material.dart';
import 'package:labirynt/utils.dart';

import 'main.dart';
import 'menu_button.dart';
import 'globals.dart' as globals;

/// Main menu screen.
class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<StatefulWidget> createState() => _MenuState();
}

/// Main menu state.
class _MenuState extends State<Menu> {
  /// Button that start game.
  void playOnClicked() {
    if (globals.gameObjects.isNotEmpty) {
      clearGameMap();
    }
    while (!isPath()) {
      if (globals.gameObjects.isNotEmpty) {
        clearGameMap();
      }
      globals.matrixSize = Random().nextInt(7)+3;
      List<List<int>> idMatrix = generateMap();
      createGameInstances(idMatrix);
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GameScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MenuButton(playOnClicked),
          ],
        ));
  }
}
