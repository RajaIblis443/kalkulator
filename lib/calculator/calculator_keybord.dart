import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalkulator/calculator/calculator_provider.dart';

class CalculatorKeybord extends ConsumerWidget {
  const CalculatorKeybord({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttons = [
      ['7', '8', '9', '÷'],
      ['4', '5', '6', 'x'],
      ['1', '2', '3', '-'],
      ['0', '.', '=', '+'],
    ];
    return Column(
      children: [
        for (var row in buttons)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((label) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      final notifier = ref.read(calculatorProvider.notifier);
                      if (label == '=') {
                        notifier.evaluate();
                      } else {
                        notifier.input(label);
                      }
                    },
                    child: Text(label, style: const TextStyle(fontSize: 24)),
                  ),
                ),
              );
            }).toList(),
          ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => ref.read(calculatorProvider.notifier).clear(),
                child: const Text('C'),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () => ref.read(calculatorProvider.notifier).delete(),
                child: const Text('⌫'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
