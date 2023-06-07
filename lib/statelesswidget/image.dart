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
      body: Center(
        child: Column(
          children: [
            Container( //images from folder
              height: 200,
                      width: 200,
                      color: Colors.blue ,
              child: Image.asset(
              'imges/img1.jpg', 
              fit: BoxFit.contain ,
                      
                      ),
            ),
            //---------one / more images
            Container( 
              height: 200,
                      width: 200,
                      color: Colors.blue ,
              child: Image.asset(
              'imges/img1.jpg', 
              fit: BoxFit.contain ,
                      
                      ),
            )
            //----images from internet
            ],
          
        ),
      ),
     ),
    );
  }
}