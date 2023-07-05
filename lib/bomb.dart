import 'package:flutter/material.dart';

class Bomb extends StatelessWidget {
  final chiled;
  bool revealed;

  Bomb({this.chiled, required this.revealed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        color: Colors.grey.shade800,
        child: Center(child: Text(chiled.toString())),
      ),
    );
  }
}
