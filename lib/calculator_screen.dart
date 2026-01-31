import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';
  String expression = '';
  double? firstOperand;
  String? operator;
  double? secondOperand;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        display = '0';
        expression = '';
        firstOperand = null;
        operator = null;
        secondOperand = null;
      } else if (value == '⌫') {
        if (display.length > 1) {
          display = display.substring(0, display.length - 1);
        } else {
          display = '0';
        }
      } else if (['+', '-', '×', '÷'].contains(value)) {
        if (firstOperand == null) {
          firstOperand = double.parse(display);
        } else if (operator != null) {
          secondOperand = double.parse(display);
          firstOperand = _calculate(firstOperand!, operator!, secondOperand!);
          display = firstOperand!.toString();
        }
        operator = value;
        expression = '$display $value';
      } else if (value == '=') {
        if (firstOperand != null && operator != null) {
          secondOperand = double.parse(display);
          double result = _calculate(firstOperand!, operator!, secondOperand!);
          display = result.toString();
          expression = '$expression $secondOperand =';
          firstOperand = null;
          operator = null;
          secondOperand = null;
        }
      } else if (value == '.') {
        if (!display.contains('.')) {
          display += '.';
        }
      } else {
        if (display == '0' ||
            ['+', '-', '×', '÷'].any((op) => expression.endsWith(op))) {
          display = value;
        } else {
          display += value;
        }
      }
    });
  }

  double _calculate(double a, String op, double b) {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '×':
        return a * b;
      case '÷':
        return b != 0 ? a / b : double.nan;
      default:
        return b;
    }
  }

  Widget _buildButton(String value, {Color? color, Color? textColor}) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(value),
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? const Color(0xFF2A2A2A),
        foregroundColor: textColor ?? Colors.white,
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        value,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        expression,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        display,
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildButton('C', color: Colors.redAccent),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildButton('⌫', color: Colors.orangeAccent),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildButton('÷', color: Colors.blueAccent),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildButton('7')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildButton('8')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildButton('9')),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildButton('×', color: Colors.blueAccent),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildButton('4')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildButton('5')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildButton('6')),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildButton('-', color: Colors.blueAccent),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildButton('1')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildButton('2')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildButton('3')),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildButton('+', color: Colors.blueAccent),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildButton('0')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildButton('.')),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildButton('=', color: Colors.greenAccent),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
