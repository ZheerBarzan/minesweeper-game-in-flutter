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
  List<int> mineLocation = [4, 28, 61, 10, 20, 62];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < numberOfSqures; i++) {
      squreStatus.add([0, false]);
    }
    scanBombs();
  }

  void revealBoxNumbers(int index) {
    setState(() {
      squreStatus[index][1] = true;
    });
  }

  void scanBombs() {
    for (int i = 0; i < numberOfSqures; i++) {
      // no bombs at the start of the game
      int numberOfBombsAround = 0;

      // now we need to check for the 8 cells surrounding the mine

      // 1st checking to the left unless its in the first column
      if (mineLocation.contains(i - 1) && i % numberInEachRow != 0) {
        numberOfBombsAround++;
      }
      // 2nd checking for top left cell unless its the frist column or first row
      if (mineLocation.contains(i - 1 - numberInEachRow) &&
          i % numberInEachRow != 0 &&
          i >= numberInEachRow) {
        numberOfBombsAround++;
      }
      // 3rd checking for top cell unless it the first row
      if (mineLocation.contains(i - numberInEachRow) && i >= numberInEachRow) {
        numberOfBombsAround++;
      }
      // 4th checking for top right cell unless its the frist row or first last column
      if (mineLocation.contains(i + 1 - numberInEachRow) &&
          i >= numberInEachRow &&
          i % numberInEachRow != numberInEachRow - 1) {
        numberOfBombsAround++;
      }
      // 5th checking for the cell on the right unless its the last column
      if (mineLocation.contains(i + 1) &&
          i % numberInEachRow != numberInEachRow - 1) {
        numberOfBombsAround++;
      }
      // 6th checking the cell on the bottom right unless its the last column or last row
      if (mineLocation.contains(i + 1 + numberInEachRow) &&
          i % numberInEachRow != numberInEachRow - 1 &&
          i < numberOfSqures - numberInEachRow) {
        numberOfBombsAround++;
      }
      // 7th checking the cell on the bottom unless its the last row
      if (mineLocation.contains(i + numberInEachRow) &&
          i < numberOfSqures - numberInEachRow) {
        numberOfBombsAround++;
      }
      // 8th cheking the cell on the bottom left unless its the last row or first column
      if (mineLocation.contains(i - 1 + numberInEachRow) &&
          i < numberOfSqures - numberInEachRow &&
          i % numberInEachRow != 0) {
        numberOfBombsAround++;
      }

      // add the total number of mines around to square status
      setState(() {
        squreStatus[i][0] = numberOfBombsAround;
      });
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
                      revealed: squreStatus[index][1],
                      function: () {
                        // if a player taps this they will lose the game
                      },
                    );
                  } else {
                    return NumberBox(
                      chiled: squreStatus[index][0],
                      revealed: squreStatus[index][1],
                      function: () {
                        // if a player taps this they will reveal the square
                        revealBoxNumbers(index);
                      },
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
