# Dart performance assignment part 1

Assignment taken from https://adventofcode.com/2022/day/24

1) Read the assignment of day 24: calculate the least number of minutes it takes to walk through the blizzards

2) Together, try to understand the solution in part1.dart:
- Reading the data using _fillPositionsAndBlizzards, which makes a list of all blizards and all positions and whether there is a rock
- Starting from the first position, make a list of all adjacent positions that are free and add them to the queue
- Every minute increment, shift the blizards in the required position and make a new list of the adjacent free positions for every position in the current queue
- When the goal is in the next queue, the other side has been reached and we know how many minutes it took

3) See how you can improve the performance of this solution
- Answer should still be the same
- Debugging doesn't stop the timer, so don't trust the reported time when using a break point
- Start with _passThroughBlizzards: here you can use Sets instead of lists for the queues (see tips section below)

4) An example of a faster solution is in _part1.dart, you can run it by changing the import in bin/main.dart


########### TIPS BELOW ###########

> Object creation
- Don't create/recompute new objects inside loops unnecessarily
- Use const when a value is always the same, instead of mutable variables
- Use final when only assigning a value once, instead of mutable variables
- Cache frequently accessed data

> Collections
- Use Set instead of List for unique collections. This will immediately deduplicate input and greatly improves lookup performance.
- When using lists that don't change, use (growable: false) in toList(). This fixes the allocated memory size for the list and improves performance because it will not dynamically resize the list.
- Use indexed arrays or Maps for grids instead of long lists.
Say you have a map with coordinates and values, then you could use Map<int, Map<int, String>> 
where the first int (the keys of the first Map) is the Y coordinate, and the second int (the keys of the second Map) is the X coordinate.
You can quickly first find the correct row map[Y] and then the place in the row map[Y][X] to find the String value of that position.

> Efficient code behaviour
- Don't use nested loops, prefer forEach and map
- Use efficient methods like 'where' (LINQ like)
- You can use break to exit a 'while' or 'for' loop instead of completing it (can be useful)

> More online:
- https://clouddevs.com/dart/performance-optimization-techniques/
- https://dart.dev/effective-dart en https://dart.dev/effective-dart/usage

> Maybe you find more!
- Out of scope, but interesting for another time: rendering performance / rebuilds etc. in Flutter/Dart