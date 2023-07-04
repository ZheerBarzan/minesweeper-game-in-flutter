import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variables

  int numberOfSqures = 9 * 9;
  int numberInEachRow = 9;
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

                // this button refreshs the game
                Card(
                  color: Colors.grey,
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 40,
                  ),
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
          ),

          //grid
          Expanded(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: numberOfSqures,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numberInEachRow),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      color: Colors.blue,
                    ),
                  );
                }),
          ),

          //branding
        ],
      ),
    );
  }
}
