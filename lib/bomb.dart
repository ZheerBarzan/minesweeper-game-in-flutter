import 'package:flutter/material.dart';

class Bomb extends StatelessWidget {
  final bool revealed;
  final function;

  Bomb({required this.revealed, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: Colors.grey.shade400,
          child: revealed
              ? const Icon(
                  Icons.local_fire_department,
                  color: Colors.red,
                )
              : Container(
                  color: Colors.grey.shade400,
                ),
        ),
      ),
    );
  }
}
