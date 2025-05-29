import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalkulator/calculator/calculator_state.dart';
import 'package:math_expressions/math_expressions.dart';

final calculatorProvider = NotifierProvider(() => CalculatorNotifer());

class CalculatorNotifer extends Notifier<CalculatorState> {
  @override
  build() {
    return CalculatorState();
  }

  void input(String value) {
    state = state.copyWith(expresion: state.expression + value);
  }

  void clear() {
    state = state.copyWith(expresion: '', result: '');
  }

  void delete() {
    if (state.expression.isNotEmpty) {
      state = state.copyWith(
        expresion: state.expression.substring(0, state.expression.length - 1),
      );
    }
  }

  void evaluate() {
    try {
      final result = _elvaluateExpresion(state.expression);
      final historyItem = '${state.expression} = $result';
      final updateHistory = List<String>.from(state.history)..add(historyItem);

      state = state.copyWith(
        result: result.toString(),
        history: updateHistory,
        expresion: result.toString(),
      );
    } catch (e) {
      state = state.copyWith(result: 'Error');
    }
  }

  double _elvaluateExpresion(String expresion) {
    final exrp = expresion.replaceAll('x', '*').replaceAll('÷', '/');
    return double.parse(_parseAndComputed(exrp));
  }

  String _parseAndComputed(String expresion) {
    try {
      GrammarParser parser = GrammarParser();
      Expression expression = parser.parse(expresion);

      ContextModel contextModel = ContextModel();
      double result = expression.evaluate(EvaluationType.REAL, contextModel);

      return result.toString();
    } catch (e) {
      return '0';
    }
  }
}
