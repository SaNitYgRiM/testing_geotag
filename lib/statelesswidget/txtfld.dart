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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: "user name",//
              hintText: "enter your username" ,
              prefixIcon:Icon(Icons.verified_user) ,//in the first
              suffixIcon: Icon(Icons.verified),//last
              ),
            ),
            const TextField(
              decoration: InputDecoration(labelText: "user name",//
              hintText: "enter your username" ,
              suffixText: "mr.",
              prefixText: "mr.",
              ),
            ),
            const TextField(
              decoration: InputDecoration(labelText: "user name",//
              hintText: "enter your username" ,
              helperText: "enter your username or email",
              hintStyle: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color:Colors.amberAccent,
              ),
              labelStyle: TextStyle(
                fontSize: 20,
                color: Colors.pink,  //user name
                fontStyle: FontStyle.italic,
              ),
              ),
            ),
            const TextField(
              maxLength: 10,
              obscureText: true,//password eg 
              keyboardType: TextInputType.number,//only numbers able to write
            ),
            //------------------------------------------------------------------
            TextField(
               decoration: InputDecoration(
               focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                   color: Colors.black
                  ),
                ),
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                   color: Colors.black
                  ),
                ),

                label: const Text("user name"),
               ),
            ),
            const TextField(
              textAlign:TextAlign.center,
              decoration: InputDecoration(
                filled:true,
                fillColor: Colors.blue, 
              ),
            ),
          ],
          ),
           ),
      ),
     ),
    );
  }
}