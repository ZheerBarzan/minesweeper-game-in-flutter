import 'package:flutter/material.dart';

class NumberBox extends StatelessWidget {
  final chiled;
  bool revealed;
  final function;

  NumberBox({this.chiled, required this.revealed, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: revealed ? Colors.grey.shade300 : Colors.grey.shade400,
          child: Center(child: Text(revealed ? chiled.toString() : '')),
        ),
      ),
    );
  }
}
