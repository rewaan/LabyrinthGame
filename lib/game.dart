import 'package:flutter/material.dart';
import 'package:labirynt/side_button.dart';
import 'package:labirynt/utils.dart';
import 'exit_button.dart';
import 'globals.dart' as globals;
import 'main.dart';

/// Main Game class that have whole UI.
class Game extends StatefulWidget {
  int x;
  int y;
  String imagePath;
  bool isStart = false;
  bool isEnd = false;
  bool outOfGame = false;

  Game(this.x, this.y, this.imagePath, this.isStart, this.isEnd, this.outOfGame,
      {super.key});

  Game.withoutStart(this.x, this.y, this.imagePath, {super.key});

  @override
  State<StatefulWidget> createState() => _Game();
}

/// Game class State.
class _Game extends State<Game> {
  /// Move on clicked function that checks if neighborhood object exists.
  void moveOnClicked(direction) {
    int newX = widget.x;
    int newY = widget.y;
    if (direction == "Left") {
      newX = newX - 1;
    } else if (direction == "Right") {
      newX = newX + 1;
    } else if (direction == "Up") {
      newY = newY - 1;
    } else {
      newY = newY + 1;
    }
    globals.wasVisited[newY][newX] = true;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => globals.gameObjects[newX][newY],
        ));
  }

  /// Exits to main menu if clicked.
  void exitOnClicked() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    String imagePath = widget.imagePath;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Labyrinth'),
          centerTitle: true,
          automaticallyImplyLeading: widget.isStart,
        ),
        body: Stack(
            fit: StackFit.loose,
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  image: DecorationImage(
                      image: AssetImage(imagePath), fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SideButton(
                        "Up", moveOnClicked, widget.y == 0 || widget.isEnd || globals.gameObjects[widget.x][widget.y - 1].outOfGame),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SideButton("Left", moveOnClicked,
                                  widget.x == 0 || widget.isEnd || globals.gameObjects[widget.x - 1][widget.y].outOfGame),
                            ],
                          ),
                        ),
                        widget.isEnd
                            ? Container(
                                decoration: const BoxDecoration(
                                  color: Colors.lightGreenAccent,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      child: const Text(
                                        "Gratulacje. Ujebales!",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              SideButton(
                                  "Right",
                                  moveOnClicked,
                                  widget.x + 1 == globals.matrixSize ||
                                      widget.isEnd || globals.gameObjects[widget.x + 1][widget.y].outOfGame),
                            ],
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height:
                                MediaQuery.of(context).size.height * 0.15,
                                child: const Text(
                                  "Legend:"
                                      "[B] - Blocked"
                                      "[X] - Already visited"
                                      "[0] - Not visited"
                                      "[S] - Start pos",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: Text(
                                  drawMap(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              ExitButton(exitOnClicked),
                            ],
                          ),
                        )
                      ],
                    ),
                    SideButton("Down", moveOnClicked,
                        widget.y + 1 == globals.matrixSize || widget.isEnd || globals.gameObjects[widget.x][widget.y + 1].outOfGame),
                  ],
                ),
              ),
            ]));
  }
}
