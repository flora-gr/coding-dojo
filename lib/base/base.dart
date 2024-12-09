import 'dart:io';

Future<void> run(int index) async {
  final List<String> example =
      await File('./input/part$index/example').readAsLines();
  final List<String> input =
      await File('./input/part$index/input').readAsLines();

  final Stopwatch stopwatch = Stopwatch()..start();
  final Object exampleSolution = calculate(example);
  stopwatch.stop();
  final int firstExampleTime = stopwatch.elapsedMilliseconds;

  stopwatch
    ..reset()
    ..start();
  final Object solution = calculate(input);
  stopwatch.stop();
  final int solutionTime = stopwatch.elapsedMilliseconds;

  print('\nResults part $index:\n'
      'Example answer: $exampleSolution (${_isCorrect(exampleSolution, exampleAnswer) ? 'correct' : 'incorrect'}) - '
      'Example time: ${firstExampleTime}ms\n'
      'Solution answer: $solution (${_isCorrect(solution, solutionAnswer) ? 'correct' : 'incorrect'})- '
      'Solution time: ${solutionTime}ms');
}

late Object Function(List<String> dataLines) calculate;
late Object exampleAnswer;
late Object solutionAnswer;

bool _isCorrect(Object exampleSolution, Object exampleAnswer) {
  if (exampleSolution is List && exampleAnswer is List) {
    return exampleSolution.length == exampleAnswer.length &&
        exampleAnswer.every((dynamic element) =>
            exampleSolution[exampleAnswer.indexOf(element)] == element);
  } else {
    return exampleSolution == exampleAnswer;
  }
}
