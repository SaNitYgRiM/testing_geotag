//add row and colum

import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "complaint_register",
      home: Scaffold(
        body:Row(
          mainAxisAlignment:MainAxisAlignment.start ,
          children: [
            Container(
              width: 100,
              height: 50,
              color: Colors.blue,
            ),
            Container(
              width: 100,
              height: 50,
              color: Colors.black,
            ),
            Container(
              width: 100,
              height: 50,
              color: Colors.pink,
            ),
          ],
        ),
          
      ),
    
      );
  }
}