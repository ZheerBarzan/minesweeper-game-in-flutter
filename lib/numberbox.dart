import 'package:flutter/material.dart';

class NumberBox extends StatelessWidget {
  final chiled;

  NumberBox({this.chiled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        color: Colors.grey.shade400,
        child: Center(child: Text(chiled.toString())),
      ),
    );
  }
}
