class CalculatorState {
  final String expression;
  final String result;
  final List<String> history;
  CalculatorState({
    this.expression = '',
    this.result = '',
    this.history = const [],
  });

  CalculatorState copyWith({
    String? expresion,
    String? result,
    List<String>? history,
  }) {
    return CalculatorState(
      expression: expresion ?? expression,
      result: result ?? this.result,
      history: history ?? this.history,
    );
  }
}
