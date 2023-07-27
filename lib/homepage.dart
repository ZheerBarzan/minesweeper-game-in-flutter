import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minesweeper_game/bomb.dart';
import 'package:minesweeper_game/numberbox.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Stopwatch stopwatch = Stopwatch();
Timer? timer;

class _HomePageState extends State<HomePage> {
  //variables

  static int numberOfSqures = 9 * 9;
  static int numberInEachRow = 9;

// [number of the bombs around,   reveled true/false]
  var squreStatus = [];

// mine locations it generates it randomly
  List<int> mineLocation =
      List.generate(numberInEachRow, (_) => Random().nextInt(numberOfSqures));

  bool minesRevealed = false;

  @override
  void initState() {
    super.initState();
    // intially every cell has 0 bombs around and its not revealed
    for (int i = 0; i < numberOfSqures; i++) {
      squreStatus.add([0, false]);
      stopwatch.start();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {});
      });
    }

    scanBombs();
  }

  void restartTheGame() {
    setState(() {
      minesRevealed = false;
      for (int i = 0; i < numberOfSqures; i++) {
        squreStatus[i][1] = false;
      }
      stopwatch.reset();
    });
  }

  void revealBoxNumbers(int index) {
    // reveal the number cells if the number is: 1,2,3 etc..
    if (squreStatus[index][0] != 0) {
      setState(() {
        squreStatus[index][1] = true;
      });
    }
    // if the current cells is 0
    else if (squreStatus[index][0] == 0) {
      //reveal 8 surrounding cells unless you are on a wall
      setState(() {
        // reveal the current cells
        squreStatus[index][0] = "";

        if (index % numberInEachRow != 0) {
          // if the box isnt revealed and is a 0 then recurse
          if (squreStatus[index - 1][0] == 0 &&
              squreStatus[index - 1][1] == false) {
            revealBoxNumbers(index - 1);
          }
          // reveal the left cells
          squreStatus[index - 1][1] = true;
        }
        if (index % numberInEachRow != 0 && index >= numberInEachRow) {
          if (squreStatus[index - 1 - numberInEachRow][0] == 0 &&
              squreStatus[index - 1 - numberInEachRow][1] == false) {
            revealBoxNumbers(index - 1 - numberInEachRow);
          }
          // reveal the top left cells
          squreStatus[index - 1 - numberInEachRow][1] = true;
        }
        if (index >= numberInEachRow) {
          if (squreStatus[index - numberInEachRow][0] == 0 &&
              squreStatus[index - numberInEachRow][1] == false) {
            revealBoxNumbers(index - numberInEachRow);
          }
          // reveal the top cells
          squreStatus[index - numberInEachRow][1] = true;
        }
        if (index >= numberInEachRow &&
            index % numberInEachRow != numberInEachRow - 1) {
          if (squreStatus[index + 1 - numberInEachRow][0] == 0 &&
              squreStatus[index + 1 - numberInEachRow][1] == false) {
            revealBoxNumbers(index + 1 - numberInEachRow);
          }
          // reveal the top right cells
          squreStatus[index + 1 - numberInEachRow][1] = true;
        }
        if (index % numberInEachRow != numberInEachRow - 1) {
          if (squreStatus[index + 1][0] == 0 &&
              squreStatus[index + 1][1] == false) {
            revealBoxNumbers(index + 1);
          }
          // reveal the right cells
          squreStatus[index + 1][1] = true;
        }
        if (index < numberOfSqures - numberInEachRow &&
            index % numberInEachRow != numberInEachRow - 1) {
          if (squreStatus[index + 1 + numberInEachRow][0] == 0 &&
              squreStatus[index + 1 + numberInEachRow][1] == false) {
            revealBoxNumbers(index + 1 + numberInEachRow);
          }
          // reveal the bottom right cells
          squreStatus[index + 1 + numberInEachRow][1] = true;
        }
        if (index < numberOfSqures - numberInEachRow) {
          if (squreStatus[index + numberInEachRow][0] == 0 &&
              squreStatus[index + numberInEachRow][1] == false) {
            revealBoxNumbers(index + numberInEachRow);
          }
          // reveal the bottom cells
          squreStatus[index + numberInEachRow][1] = true;
        }
        if (index < numberOfSqures - numberInEachRow &&
            index % numberInEachRow != 0) {
          if (squreStatus[index - 1 + numberInEachRow][0] == 0 &&
              squreStatus[index - 1 + numberInEachRow][1] == false) {
            revealBoxNumbers(index - 1 + numberInEachRow);
          }
          // reveal the bottom left cells
          squreStatus[index - 1 + numberInEachRow][1] = true;
        }
      });
    }
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

  void playerLost() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade700,
            title: const Center(
              child: Text(
                "YOU LOST 😢",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              MaterialButton(
                color: Colors.grey.shade100,
                onPressed: () {
                  restartTheGame();
                  Navigator.pop(context);
                },
                child: const Icon(Icons.refresh),
              )
            ],
          );
        });
  }

  void playerWon() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade700,
            title: const Center(
              child: Text(
                "YOU WON ✌️😎",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              MaterialButton(
                  color: Colors.grey.shade100,
                  onPressed: () {
                    restartTheGame();
                    Navigator.pop(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.grey.shade300,
                      child: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.refresh,
                          size: 30,
                        ),
                      ),
                    ),
                  ))
            ],
          );
        });
  }

  void checkWinner() {
    int unrevealedBoxes = 0;
    for (int i = 0; i < numberOfSqures; i++) {
      if (squreStatus[i][1] = false) {
        unrevealedBoxes++;
      }
    }

    if (unrevealedBoxes == mineLocation.length) {
      playerWon();
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //this column is the number of mines in the screen
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mineLocation.length.toString(),
                      style: const TextStyle(fontSize: 40),
                    ),
                    const Text("M I N E S")
                  ],
                ),

                // this button refreshs the game
                GestureDetector(
                  onTap: restartTheGame,
                  child: const Card(
                    color: Colors.black,
                    child: Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),

                //this column is the timer to finish the game
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${stopwatch.elapsed.inSeconds}",
                      style: const TextStyle(fontSize: 40),
                    ),
                    const Text("T I M E R(s)")
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
                      revealed: minesRevealed,
                      function: () {
                        setState(() {
                          minesRevealed = true;
                        });
                        playerLost();
                        // if a player taps this they will lose the game
                      },
                    );
                  } else {
                    return NumberBox(
                      child: squreStatus[index][0],
                      revealed: squreStatus[index][1],
                      function: () {
                        // if a player taps this they will reveal the square
                        revealBoxNumbers(index);
                        checkWinner();
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
