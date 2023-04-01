library my_prj.globals;

import 'game.dart';

/// Game objects list necessary to play.
List<List<Game>> gameObjects = <List<Game>>[];
/// Matrix that holds information if object was already visited.
List<List<bool>> wasVisited = <List<bool>>[];
/// Holds Game matrix size.
int matrixSize = 0;