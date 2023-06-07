
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_geotag/complaint.dart';
import 'package:testing_geotag/saveimage.dart';
//import 'package:testing_geotag/complaint.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
  User? user = userCredential.user;

  if (user != null) {
    runApp(complaint());
  } else {
    print("Sign-in error!!!");
  }
}











