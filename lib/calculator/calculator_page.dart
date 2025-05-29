import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalkulator/calculator/calculator_keybord.dart';
import 'package:kalkulator/calculator/calculator_provider.dart';
import 'package:kalkulator/copyright/infome.dart';
import 'calculator_display.dart';

class CalculatorPage extends ConsumerStatefulWidget {
  const CalculatorPage({super.key});

  @override
  ConsumerState<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends ConsumerState<CalculatorPage> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKey(KeyEvent event) {
    if (event is KeyDownEvent) {
      final key = event.logicalKey.keyLabel;

      // Angka dan operator yang diperbolehkan
      const allowedKeys = [
        '0',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '+',
        '-',
        '*',
        '/',
        '.',
        'x',
        '÷',
      ];

      final notifier = ref.read(calculatorProvider.notifier);

      if (allowedKeys.contains(key)) {
        notifier.input(key);
      } else if (key == 'Enter' || key == '=') {
        notifier.evaluate();
      } else if (key == 'Backspace') {
        notifier.delete();
      } else if (key.toLowerCase() == 'c') {
        notifier.clear();
      }
    }
  }

  void _showInfoDialog() {
    showDialog(context: context, builder: (context) => const Infome());
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKey,
      child: Scaffold(
        appBar: AppBar(
          actionsPadding: EdgeInsets.symmetric(horizontal: 10),
          title: const Text('Kalkulator'),
          actions: [
            IconButton(
              onPressed: () => _showInfoDialog(),
              icon: Icon(Icons.info),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              CalculatorDisplay(),
              SizedBox(height: 16),
              Expanded(child: CalculatorKeybord()),
            ],
          ),
        ),
      ),
    );
  }
}
