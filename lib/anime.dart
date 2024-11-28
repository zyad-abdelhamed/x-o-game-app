import 'package:flutter/material.dart';

class anime extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return animeState();
  }
}

class animeState extends State<anime>{
   List<String>? _board;
  String? _currentPlayer;
  List<Color> _colors = List.generate(9, (index) => const Color.fromARGB(255, 238, 238, 238));
 
   //////////
   @override
  void initState() {
    super.initState();
    _initializeBoard();
  }


  void _initializeBoard() {
    _board = List.filled(9, '');
    _currentPlayer = 'X';
  }

   void _handleTap(int index) {
    if (_board?[index] == '') {
      setState(() {
        _board?[index] = _currentPlayer!;
        _currentPlayer = (_currentPlayer == 'X') ? 'O' : 'X';
        
      
      });
      _checkWinner();
    }
  }
   void _checkWinner() {
    // Define winning combinations
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combination in winningCombinations) {
      if (_board?[combination[0]] != '' &&
          _board?[combination[0]] == _board?[combination[1]] &&
          _board?[combination[1]] == _board?[combination[2]]) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Winner!'),
              content: Text('Player ${_board?[combination[0]]} wins!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                       _board = List.filled(9, '');
                      _colors = List.generate(9, (index) => const Color.fromARGB(255, 238, 238, 238));
                    });
                  },
                  child: const Text('Play Again',style: TextStyle(color: Colors.pinkAccent),),
                ),
              ],
            );
          },
        );
        return;
      }
    }
    // Check for draw
    if (!_board!.contains('')) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Draw!'),
            content: const Text('The game ends in a draw.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                       _board = List.filled(9, '');
                      _colors = List.generate(9, (index) => const Color.fromARGB(255, 238, 238, 238));
                    });
                },
                child: const Text('Play Again',style: TextStyle(color: Colors.pinkAccent)),
              ),
            ],
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text("X_O GAME"),
        centerTitle: true,
      ) , 
      body: ListView(physics: const NeverScrollableScrollPhysics(),children: [
        const SizedBox(height: 30,),
        Row(children: [
          const SizedBox(width: 30,),
          Container(alignment: Alignment.center,color: Colors.grey[200],width: 200,height: 50,child: const Text('Current Player:',style: TextStyle(fontSize: 25),),),
           const SizedBox(width: 30,),
          Container(alignment: Alignment.center,color: const Color.fromARGB(255, 238, 238, 238),width: 100,height: 50,child:  Text(_currentPlayer!,style: TextStyle(fontSize: 25)),),

        ],),
        const SizedBox(height: 30,),
          Container(height: 400,margin: const EdgeInsets.all(30),
            child:GridView.builder(physics: const NeverScrollableScrollPhysics(),gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,crossAxisSpacing: 10,mainAxisSpacing: 10 ), 
             itemBuilder:(context, index) {
               return  GestureDetector(
                onTap: () {
                 
                  _handleTap(index);
                 setState(() {
              
            if(  _board![index]=='X') {
              _colors[index]=Colors.deepOrange;
            }else{
               _colors[index]=Colors.teal;
            }
                  
            });
                },
                 child: AnimatedContainer(duration: const Duration(milliseconds: 350),
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                 
                 color:
                 _colors[index],),alignment: Alignment.center,
                            child: Text(_board![index],
                  style: const TextStyle(fontSize: 50.0,color: Colors.white),),
                 ),
               );
             },itemCount: 9,)
          ),
          Center(
            child: MaterialButton(onPressed: () {
                     setState(() {
                       _board = List.filled(9, '');
                      _colors = List.generate(9, (index) => const Color.fromARGB(255, 238, 238, 238));
                    });
              
            },
            color:Colors.pinkAccent ,
            child: const Text('Restart Game',style: TextStyle(color: Colors.white),),
            ),
          )
      ],)
    );
  }
  
 
 
 
}
