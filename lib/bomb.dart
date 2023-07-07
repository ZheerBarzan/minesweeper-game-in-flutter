import 'package:flutter/material.dart';

class Bomb extends StatelessWidget {
  bool revealed;
  final function;

  Bomb({required this.revealed, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: Colors.grey.shade800,
          child: const Center(child: Text("x")),
        ),
      ),
    );
  }
}
