import 'package:devtools/widgets/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({Key? key}) : super(key: key);

  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  String player1 = 'X';
  String player2 = 'O';
  String currentPlayer = 'X';
  bool gameEnd = false;
  List<String> inputs = ['', '', '', '', '', '', '', '', ''];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GridView.builder(
                      itemCount: 9,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: 0.90 / 1),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (inputs[index].isEmpty && gameEnd != true) {
                                inputs[index] = currentPlayer;
                                changePlayer();
                                whoisWinner();
                                checkForDraw();
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: inputs[index] == ''
                                  ? Colors.grey[400]
                                  : inputs[index] == 'X'
                                      ? HexColor("#f4717f")
                                      : HexColor("#6bc6a5"),
                            ),
                            child: Center(
                                child: Text(
                              inputs[index],
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )),
                          ),
                        );
                      }),
                ),
                InkWell(
                  onTap: () {
                    currentPlayer = 'X';
                    gameEnd = false;
                    inputs = ['', '', '', '', '', '', '', '', ''];
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Vx.yellow500),
                    width: 80,
                    height: 50,
                    child: const Icon(
                      Icons.restart_alt_outlined,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  changePlayer() {
    if (currentPlayer == 'X') {
      currentPlayer = player2;
    } else {
      currentPlayer = player1;
    }
  }

  checkForDraw() {
    if (gameEnd) {
      return;
    }
    bool draw = true;
    for (String pos in inputs) {
      if (pos.isEmpty) {
        draw = false;
      }
    }

    if (draw) {
      showGameOverMessage("It's a draw", 'draw');
      gameEnd = true;
    }
  }

  whoisWinner() {
    if (gameEnd) {
      return;
    }

    List<List<int>> positions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (List winningPos in positions) {
      String position0 = inputs[winningPos[0]];
      String position1 = inputs[winningPos[1]];
      String position2 = inputs[winningPos[2]];

      if (position0.isNotEmpty) {
        if (position0 == position1 && position0 == position2) {
          showGameOverMessage('$position1 won', position1);
          gameEnd = true;
        }
      }
    }
  }

  showGameOverMessage(String message, String position) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          elevation: 0.0,
          duration: const Duration(seconds: 4),
          backgroundColor: position == 'draw'
              ? Vx.fuchsia400
              : position == 'X'
                  ? HexColor("#f4717f")
                  : HexColor("#6bc6a5"),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
    );
  }
}
