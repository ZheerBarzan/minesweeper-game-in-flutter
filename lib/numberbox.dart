import 'package:flutter/material.dart';

class NumberBox extends StatelessWidget {
  final child;
  final bool revealed;
  final function;

  const NumberBox(
      {required this.child, required this.revealed, required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: revealed ? Colors.grey.shade300 : Colors.grey.shade400,
          child: Center(
            child: Text(
              revealed ? child.toString() : '',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: child == 1
                      ? Colors.blue
                      : (child == 2 ? Colors.green : Colors.red)),
            ),
          ),
        ),
      ),
    );
  }
}
