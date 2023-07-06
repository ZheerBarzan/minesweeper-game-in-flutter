import 'package:flutter/material.dart';

class Bomb extends StatelessWidget {
  final chiled;
  bool revealed;
  final function;

  Bomb({this.chiled, required this.revealed, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: Colors.grey.shade800,
          child: Center(child: Text(chiled.toString())),
        ),
      ),
    );
  }
}
