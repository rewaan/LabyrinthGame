import 'dart:math';

import 'package:tuple/tuple.dart';

import 'game.dart';

import 'globals.dart' as globals;

/// Generates Game map.
List<List<int>> generateMap() {
  List<int> alreadyPresent = [];
  List<List<int>> matrix = <List<int>>[];
  int allPoles = globals.matrixSize * globals.matrixSize;
  for (int i = 0; i < globals.matrixSize; i++) {
    List<int> list = <int>[];
    for (int j = 0; j < globals.matrixSize; j++) {
      int id = Random().nextInt(allPoles) + 1;
      while (alreadyPresent.contains(id)) {
        id = Random().nextInt(allPoles) + 1;
      }
      alreadyPresent.add(id);
      list.add(id);
    }
    matrix.add(list);
  }
  return matrix;
}

/// Gets start and end position.
Tuple2<Tuple2<int, int>, Tuple2<int, int>> getStartAndEndIndex(
    List<List<int>> idMatrix, int n) {
  late Tuple2<int, int> startPos;
  late Tuple2<int, int> endPos;
  List<int> alreadyPresent = [];
  for (int i = 0; i < n; i += 1) {
    for (int j = 0; j < n; j += 1) {
      int id = Random().nextInt(n*n);
      while (alreadyPresent.contains(id)) {
        id = Random().nextInt(n*n);
      }
      alreadyPresent.add(id);
      if (id == 1) {
        startPos = Tuple2(i, j);
      } else if (id == 0) {
        endPos = Tuple2(i, j);
      }
    }
  }
  return Tuple2(startPos, endPos);
}

/// Clears game matrix's.
void clearGameMap() {
  for (int i = 0; i < globals.matrixSize; i++) {
    globals.gameObjects[i].clear();
    globals.wasVisited[i].clear();
  }
  globals.gameObjects.clear();
  globals.wasVisited.clear();
}

/// Creates Game instances.
void createGameInstances(List<List<int>> idMatrix) {
  bool isStart;
  bool isEnd;
  Tuple2<Tuple2<int, int>, Tuple2<int, int>> startAndEndPost =
      getStartAndEndIndex(idMatrix, globals.matrixSize);
  Tuple2<int, int> startPos = startAndEndPost.item1;
  Tuple2<int, int> endPos = startAndEndPost.item2;
  for (int i = 0; i < globals.matrixSize; i++) {
    List<Game> list = <Game>[];
    List<bool> wasVisitedColumn = <bool>[];
    for (int j = 0; j < globals.matrixSize; j++) {
      bool isWall = Random().nextInt(4) == 0;
      isStart = false;
      isEnd = false;
      if (i == startPos.item1 && j == startPos.item2) {
        isStart = true;
      }
      if (i == endPos.item1 && j == endPos.item2) {
        isEnd = true;
      }
      wasVisitedColumn.add(false);
      if (isStart) {
        Game gameInstance =
        Game(i, j, "assets/images/panda.jpg", isStart, isEnd, false);
        list.add(gameInstance);
        continue;
      }
      if (isEnd) {
        Game gameInstance =
        Game(i, j, "assets/images/billu.jpg", isStart, isEnd, false);
        list.add(gameInstance);
        continue;
      }
      Game gameInstance =
      Game(i, j, "assets/images/cat.jpg", isStart, isEnd, isWall);
      list.add(gameInstance);
    }
    globals.gameObjects.add(list);
    globals.wasVisited.add(wasVisitedColumn);
  }
}

/// Draws map on side panel.
String drawMap() {
  String map = "";
  for (int i = 0; i < globals.matrixSize; i++) {
    for (int j = 0; j < globals.matrixSize; j++) {
      if (globals.gameObjects[j][i].outOfGame) {
        map += '[B]';
      } else if (globals.gameObjects[j][i].isStart) {
        map += '[S]';
      } else if (globals.wasVisited[i][j]) {
        map += '[X]';
      } else {
        map += '[0]';
      }
      if (j + 1 == globals.matrixSize) {
        map += "\n";
      }
    }
  }
  return map;
}

/// Checks if field exists.
bool isSafe(i, j) {
  if (i >= 0 && i < globals.matrixSize && j >= 0 && j < globals.matrixSize) {
    return true;
  }
  return false;
}

/// Checks if map is correct.
bool checkPath(i, j, visited) {
  if (isSafe(i, j) && !globals.gameObjects[i][j].outOfGame && !visited[i][j]) {
    visited[i][j] = true;
    if (globals.gameObjects[i][j].isEnd) {
      return true;
    }

    if (checkPath(i - 1, j, visited)) {
      return true;
    }

    if (checkPath(i, j - 1, visited)) {
      return true;
    }
    if (checkPath(i + 1, j, visited)) {
      return true;
    }

    if (checkPath(i, j + 1, visited)) {
      return true;
    }
  }
  return false;
}

/// Checks if exist path between start and end fiedl.
bool isPath() {
  if (globals.gameObjects.isEmpty) {
    return false;
  }
  List<List<bool>> visited = <List<bool>>[];
  for (int i = 0; i < globals.matrixSize; i++) {
    List<bool> wasVisitedColumn = <bool>[];
    for (int j = 0; j < globals.matrixSize; j++) {
      wasVisitedColumn.add(false);
    }
    visited.add(wasVisitedColumn);
  }

  for (int i = 0; i < globals.matrixSize; i++) {
    for (int j = 0; j < globals.matrixSize; j++) {
      if (globals.gameObjects[i][j].isStart && !visited[i][j]) {
        if (checkPath(i, j, visited)) {
          return true;
        }
      }
    }
  }
  return false;
}
