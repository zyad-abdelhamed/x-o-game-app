
import 'package:flutter/material.dart';
import 'package:x_o_game/anime.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:anime(), 
      debugShowCheckedModeBanner: false,
      
    );
  }
} 




