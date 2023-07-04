import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(1023, 163, 163, 204),
      body: Column(
        children: [
          //game state and menu
          Container(
            height: 150,
            color: Colors.grey,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //this column is the number of mines in the screen
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "6",
                      style: TextStyle(fontSize: 40),
                    ),
                    Text("bomb")
                  ],
                ),
                //this column is the timer to finish the game
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "6",
                      style: TextStyle(fontSize: 40),
                    ),
                    Text("timer")
                  ],
                )
              ],
            ),
          )

          //grid

          //branding
        ],
      ),
    );
  }
}
