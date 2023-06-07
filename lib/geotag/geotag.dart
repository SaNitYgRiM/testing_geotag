import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:flutter_exif_plugin/flutter_exif_plugin.dart';
import  'package:intl/intl.dart';

class GeotagPage {
 
  String imagePath;
  GeotagPage({required this.imagePath});
  int currentIndex = 0;
  late FlutterExif exif;

  Future<void> geotagImage() async {

// Get location details
    Position position = await Geolocator.getCurrentPosition(
     desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark placemark = placemarks.first;
    String address = placemark.name ?? '';
    String city = placemark.locality ?? '';
    String state = placemark.administrativeArea ?? '';
    String country = placemark.country ?? '';
    double lat=position.latitude;
    double long=position.longitude;
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String time = DateFormat("HH:mm:ss").format(DateTime.now());

    print(address);
    print("heloooooooooooo");
    print(time);

// Set metadata and upload image
    await setExifData(
      imagePath,address: address, city: city,state: state,country: country,
      date: date,time:time,latitude:lat,longitude:long,);
    await uploadImageToStorage(imagePath);
    await addImageToFirestore(imagePath, address, city, state, country, date,time,lat,long);
print("hello2");
  }

  Future<void> setExifData(
    String imagePath, {
    required String address,required String city,required String state,
    required String country,required String date,required String time,
    required double latitude,required double longitude,
  }) async {
     final pathToImage =imagePath;
     final exif = FlutterExif.fromPath(pathToImage);
     exif.setLatLong(latitude,longitude);
     exif.setAttribute("Address",address);
     exif.setAttribute("City",city);
     exif.setAttribute("State",state);
     exif.setAttribute("Country",country);
     exif.setAttribute("Date",date);
 // apply attributes
     exif.saveAttributes();
     print("hello3");
  }

  Future<void> uploadImageToStorage(String imagePath) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference storageRef =
    firebase_storage.FirebaseStorage.instance.ref().child(fileName);
    await storageRef.putFile(File(imagePath));
    print("hello4");
  }





Future<void> addImageToFirestore(String imagePath, String address, String city, String state, String country, String date, String time, double latitude, double longitude) async {
  try {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child(imagePath);
    firebase_storage.FullMetadata metadata = await ref.getMetadata();
    
    // If no exception is thrown, it means the image exists
    String downloadURL = await ref.getDownloadURL();
      
    await FirebaseFirestore.instance.collection('pictures').add({
      'imageURL': downloadURL,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'date': date,
      'time': time,
      'latitude': latitude,
      'longitude': longitude
    });
      
    print('Image added to Firestore successfully');
  } catch (e) {
    if (e is firebase_storage.FirebaseException && e.code == 'object-not-found') {
      print('Image does not exist at the specified reference');
    } else {
      print('Error adding image to Firestore: $e');
    }
  }
}


}

/*class DisplayPage extends StatelessWidget {
  const DisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Images'),
      ),
      body: const Center(
        child: Text('Display Page'),
      ),
    );
  }
}*/
