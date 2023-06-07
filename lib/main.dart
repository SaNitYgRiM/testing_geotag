
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_geotag/saveimage.dart';
 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  runApp(MyApp());
}
Future<void> signInAnonymously() async {
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

