import 'package:flutter/material.dart';

 void main() {
  runApp(const Myapp());
}
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home:Scaffold(
      body: Column(//listview is used instead of colum which help to scroll down the page 
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.orangeAccent,
              child: Column(
                children: [
                  ListTile(//change the color of the text
                    title: const Text("hi"),
                    subtitle: const Text("hello h ru"),
                    textColor: Colors.white,
                    leading: const Icon(Icons.movie),
                    iconColor: Colors.white ,
                    trailing: const Icon(Icons.more_horiz),
                    onTap: () { },
                  )
                ],
              ),
            ),
          ),

          //---------------
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.orangeAccent,
              shadowColor: Colors.red,
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  ListTile(//change the color of the text
                    title: const Text("hi"),
                    subtitle: const Text("hello h ru"),
                    textColor: Colors.white,
                    leading: const Icon(Icons.movie),
                    iconColor: Colors.white ,
                    trailing: const Icon(Icons.more_horiz),
                    onTap: () { },
                  )
                ],
              ),
            ),
          ),
         ],
      ),
     ),
    );
  }
}