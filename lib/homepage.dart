import 'package:flutter/material.dart';
import 'package:minesweeper_game/bomb.dart';
import 'package:minesweeper_game/numberbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variables

  int numberOfSqures = 9 * 9;
  int numberInEachRow = 9;

// [number of the bombs around,   reveled true/false]
  var squreStatus = [];

// mine locations
  List<int> mineLocation = [4, 40, 61];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < numberOfSqures; i++) {
      squreStatus.add([0, false]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(1023, 163, 163, 204),
      body: Column(
        children: [
          //game state and menu
          Container(
            height: 150,
            // color: Colors.grey,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //this column is the number of mines in the screen
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "0",
                      style: TextStyle(fontSize: 40),
                    ),
                    Text("bomb")
                  ],
                ),

                // this button refreshs the game
                Card(
                  color: Colors.black,
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
                      "0",
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
                  if (mineLocation.contains(index)) {
                    return Bomb(
                      chiled: index,
                      revealed: squreStatus[index][1],
                    );
                  } else {
                    return NumberBox(
                      chiled: index,
                      revealed: squreStatus[index][1],
                    );
                  }
                }),
          ),

          //branding
          const Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Text("CREATED BY ZHEER BARZAN"),
          )
        ],
      ),
    );
  }
}
