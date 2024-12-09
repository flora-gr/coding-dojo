import 'dart:core';
import 'base/base.dart' as base;

// Assignment taken from https://adventofcode.com/2022/day/24

Future<void> calculate() async {
  base.calculate = _passBlizzards;
  base.exampleAnswer = 18;
  base.solutionAnswer = 240;
  await base.run(1);
}

final String rock = '#';
final String free = '.';
late List<Position> positions;
late List<Blizzard> blizzards;
late int maxX;
late int maxY;

int _passBlizzards(List<String> dataLines) {
  _fillPositionsAndBlizards(dataLines);
  var start = Position(X: 1, Y: 0);
  maxX = dataLines.first.length - 1;
  maxY = dataLines.length - 1;
  var end = Position(X: maxX - 1, Y: maxY);
  int minutes = _passThroughBlizzards(start, end);
  return minutes;
}

void _fillPositionsAndBlizards(List<String> dataLines) {
  positions = <Position>[];
  blizzards = <Blizzard>[];
  for (int i = 0; i < dataLines.length; i++) {
    final List<String> split = dataLines[i].split('');
    for (int j = 0; j < split.length; j++) {
      final String element = split[j];
      if (element == rock) {
        positions.add(Position(X: j, Y: i, isRock: true));
      } else {
        if (element != free) {
          blizzards.add(Blizzard(
            direction: element,
            position: Position(X: j, Y: i),
          ));
        }
        positions.add(Position(X: j, Y: i));
      }
    }
  }
}

int _passThroughBlizzards(Position begin, Position goal) {
  int minutes = 0;
  Set<Position> queue = <Position>{...begin.getAdjacentFree()};
  final Set<Position> nextQueue = <Position>{};
  while (!queue.contains(goal)) {
    _shiftBlizzards();
    for (Position pos in queue) {
      nextQueue.addAll(pos.getAdjacentFree());
    }
    queue = Set<Position>.from(nextQueue);
    nextQueue.clear();
    minutes++;
  }
  return minutes;
}

void _shiftBlizzards() {
  var newBlizzards = <Blizzard>[];
  for (Blizzard blizzard in blizzards) {
    Position currentPos = blizzard.position;
    Position? nextPos;
    if (blizzard.direction == '>') {
      nextPos = positions
          .singleWhere((p) => p.Y == currentPos.Y && p.X == currentPos.X + 1);
      if (nextPos.isRock) {
        nextPos = Position(X: 1, Y: currentPos.Y);
      }
    } else if (blizzard.direction == '<') {
      nextPos = positions
          .singleWhere((p) => p.Y == currentPos.Y && p.X == currentPos.X - 1);
      if (nextPos.isRock) {
        nextPos = Position(X: maxX - 1, Y: currentPos.Y);
      }
    } else if (blizzard.direction == '^') {
      nextPos = positions
          .singleWhere((p) => p.Y == currentPos.Y - 1 && p.X == currentPos.X);
      if (nextPos.isRock) {
        nextPos = Position(X: currentPos.X, Y: maxY - 1);
      }
    } else if (blizzard.direction == 'v') {
      nextPos = positions
          .singleWhere((p) => p.Y == currentPos.Y + 1 && p.X == currentPos.X);
      if (nextPos.isRock) {
        nextPos = Position(X: currentPos.X, Y: 1);
      }
    }
    blizzard.position = nextPos!;
    newBlizzards.add(blizzard);
  }
  blizzards = newBlizzards;
}

class Blizzard {
  Blizzard({
    required this.direction,
    required this.position,
  });
  final String direction;
  Position position;
}

class Position {
  Position({
    required this.X,
    required this.Y,
    this.isRock = false,
  });
  int X;
  int Y;
  bool isRock;

  @override
  bool operator ==(Object other) =>
      other is Position &&
      other.runtimeType == runtimeType &&
      other.X == X &&
      other.Y == Y;

  @override
  int get hashCode => '$X,$Y'.hashCode;
}

extension PositionExtension on Position {
  Iterable<Position> getAdjacentFree() {
    return <Position>[
      ...positions.where((Position pos) =>
          pos.Y == Y &&
          (pos.X == X || pos.X == X + 1 || pos.X == X - 1) &&
          !pos.isRock &&
          !blizzards.any((Blizzard blizzard) => blizzard.position == pos)),
      if (Y > 1)
        ...positions.where((Position pos) =>
            pos.Y == Y - 1 &&
            pos.X == X &&
            !pos.isRock &&
            !blizzards.any((Blizzard blizzard) => blizzard.position == pos)),
      if (Y < maxY)
        ...positions.where((Position pos) =>
            pos.Y == Y + 1 &&
            pos.X == X &&
            !pos.isRock &&
            !blizzards.any((Blizzard blizzard) => blizzard.position == pos)),
    ];
  }
}
