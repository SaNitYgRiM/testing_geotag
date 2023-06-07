import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_geotag/saveimage.dart';

class signin extends StatelessWidget {


  Future<void> _signInAnonymously() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      User? user = userCredential.user;
      if (user != null) 
        // Handle sign-in success
        MyApp();
        else
        print("sigin in error!!!");

    } catch (e) {
      // Handle sign-in error
      print('Sign-in error: $e');
    }
  }

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
     
    );
  }
}


