import 'package:flutter/material.dart';
import 'package:labirynt/game.dart';
import 'package:labirynt/menu.dart';
import 'globals.dart' as globals;

void main() => runApp(const MyApp());

/// Main App class.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Labyrinth",
      home: Home(),
    );
  }
}

/// Home screen.
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Labyrinth'),
        centerTitle: true,
      ),
      body: const Menu(),
      backgroundColor: Colors.brown,
    );
  }
}

/// First GameScreen.
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  /// Gets start object from created objects. If not found, returns first.
  Game getStartObject() {
    for (List<Game> objectList in globals.gameObjects) {
      for (Game object in objectList) {
        if (object.isStart) {
          globals.wasVisited[object.y][object.x] = true;
          return object;
        }
      }
    }
    return globals.gameObjects[0][0];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getStartObject(),
    );
  }
}
