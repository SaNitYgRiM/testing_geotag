import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: "complaint_register",
      home: Scaffold(
        body:Center(
          child: Text(
            "learn flutter",
            style: TextStyle(
              fontSize: 40,
              color: Colors.brown,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              letterSpacing: 10,
              wordSpacing: 10,
              backgroundColor: Colors.deepOrange,
              shadows: [
                Shadow(
                  color: Colors.green,
                  offset: Offset(5, 5),//shadow depth
                  blurRadius: 15,//letter blur
                )
              ]
                ),
          ),
        )
      ),
    
      );

  }
}