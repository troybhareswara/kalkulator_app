import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator Flutter',
      theme: ThemeData.dark(),
      home: const KalkulatorPage(),
    );
  }
}

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  String userInput = '';
  String result = '0';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    userInput,
                    style: const TextStyle(fontSize: 26, color: Colors.white70),
                  ),
                  Text(
                    result,
                    style: const TextStyle(fontSize: 42, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final button = buttons[index];
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isOperator(button)
                          ? const Color.fromARGB(255, 104, 64, 4)
                          : Colors.grey[850],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: () => _onButtonPressed(button),
                    child: Text(
                      button,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Tambahan footer nama kamu di bawah kalkulator
          Padding(
            padding: const EdgeInsets.only(bottom: 12, top: 4),
            child: Text(
              'Copyright © 2025 Troy Bhareswara',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isOperator(String x) {
    return (x == '/' ||
        x == 'x' ||
        x == '-' ||
        x == '+' ||
        x == '=' ||
        x == '%');
  }

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        userInput = '';
        result = '0';
      } else if (value == 'DEL') {
        userInput = userInput.isNotEmpty
            ? userInput.substring(0, userInput.length - 1)
            : '';
      } else if (value == '=') {
        result = _calculate();
      } else {
        userInput += value;
      }
    });
  }

  String _calculate() {
    String finalInput = userInput.replaceAll('x', '*');
    Parser p = Parser();
    try {
      Expression exp = p.parse(finalInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString();
    } catch (e) {
      return 'Error';
    }
  }
}
