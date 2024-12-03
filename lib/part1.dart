import 'dart:core';
import 'base/base.dart' as base;

Future<void> calculate() async {
  base.calculate = _first;
  base.exampleAnswer = 0;

  await base.run(1);
}

int _first(List<String> dataLines) {
  return 0;
}
