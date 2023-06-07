import 'dart:developer';

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
        body:Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
         children: [
          //-------------------------------------------------------------------------text button

          TextButton( 
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                fontSize: 30, 
                ),
              ),
              foregroundColor: MaterialStateProperty.all(Colors.blueGrey)
            ),                    
            onPressed:(){
                log("clicked");
            },
             child:const Text("textbutton")),
             //-------------------------------------------------------------------textbutton icon

             TextButton.icon( 
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                fontSize: 30, 
                ),
              ),
              foregroundColor: MaterialStateProperty.all(Colors.blueGrey)
            ),                    //text button
            onPressed:(){
                log("clicked");
            },
            onLongPress: (){
              log("long pressed");
            },
             icon:const Icon(Icons.home),
             label: const Text("home"),
             ),


             //------------------------------------------------------------------------elevated button
             ElevatedButton(
      
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.only(
                  left: 50,
                  right:50,
                  top: 10,
                  bottom: 10, 

                )),
                foregroundColor: MaterialStateProperty.all(Colors.red),
                backgroundColor: MaterialStateProperty.all(Colors.orange),
                minimumSize:MaterialStateProperty.all(const Size(10, 10)),
                textStyle: MaterialStateProperty.all(const TextStyle(
                  fontSize: 20,
                ))
              ),
              onPressed: () {},
              child:const Text("sign in")
              ),

              //----------------------------------------------------------------------------------- otlined button
              OutlinedButton(
                style: ButtonStyle( 
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      color: Colors.amberAccent,
                      width: 2,

                    )
                  ),
                  textStyle:MaterialStateProperty.all(
                    const TextStyle(
                    fontSize:20 )),
                  minimumSize: MaterialStateProperty.all(const Size(100, 50)),
                  foregroundColor: MaterialStateProperty.all(Colors.tealAccent),
                ),
                onPressed: () {},
               child: const Text("sing up"))
         ],  
          ),
           ),
      ),
    
      );

  }
}