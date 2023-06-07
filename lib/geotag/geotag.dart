import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class GeotagPage {
  late String imagePath;
  String fileName = "";
  List<String> pictureids = []; // Changed to List
  List<DocumentReference> picDocRef = []; // Changed to List

  GeotagPage({imagePath});

  Future<void> geotagImage(imagePath) async {
    // Permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request location permission
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Permission still denied, handle accordingly
        print('Location permission denied');
      }
    }

    // Get location details
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark placemark = placemarks.first;
    String address = placemark.name ?? '';
    String city = placemark.locality ?? '';
    String state = placemark.administrativeArea ?? '';
    String country = placemark.country ?? '';
    double lat = position.latitude;
    double long = position.longitude;
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String time = DateFormat("HH:mm:ss").format(DateTime.now());
    print(placemark.subAdministrativeArea);
    print(placemark.street);
    print(placemark.subLocality);
    print(placemark.postalCode);
    print(placemark.thoroughfare);
    print(placemark.subThoroughfare);

    print(address);
    print("heloooooooooooo");
    print(time);

    await uploadImageToStorage(
      imagePath,
      address: address,
      city: city,
      state: state,
      country: country,
      date: date,
      time: time,
      latitude: lat,
      longitude: long,
    );
    await addImageToFirestore(
      imagePath,
      address,
      city,
      state,
      country,
      date,
      time,
      lat,
      long,
    );

    print("hello2");
  }

  Future<void> uploadImageToStorage(
    String imagePath, {
    required String address,
    required String city,
    required String state,
    required String country,
    required String date,
    required String time,
    required double latitude,
    required double longitude,
  }) async {
    fileName = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance.ref().child(fileName);
    await storageRef.putFile(File(imagePath));

    final newCustomMetadata = firebase_storage.SettableMetadata(
      customMetadata: {
        'city': city,
        'state': state,
        'country': country,
        'date': date,
        'time': time,
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      },
    );

    final metadata = await storageRef.updateMetadata(newCustomMetadata);

    print(metadata);
  }

  Future<void> addPictureToComplaint(
    String complaintId,
    Map<String, dynamic> pictureData,
  ) async {
    CollectionReference complaintsCollection =
        FirebaseFirestore.instance.collection('complaints');
    DocumentReference complaintRef = complaintsCollection.doc(complaintId);
    CollectionReference picturesCollection =
        complaintRef.collection('pictures');

    await picturesCollection.add(pictureData);
  }

  Future<void> addImageToFirestore(
    String imagePath,
    String address,
    String city,
    String state,
    String country,
    String date,
    String time,
    double latitude,
    double longitude,
  ) async {
    try {
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      String downloadURL = await ref.getDownloadURL();

      DocumentReference picref =
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
      picDocRef.add(picref);
      pictureids.add(picref.id);
    } catch (e) {
      if (e is firebase_storage.FirebaseException &&
          e.code == 'object-not-found') {
        print('Image does not exist at the specified reference');
      } else {
        print('Error adding image to Firestore: $e');
      }
    }
  }

  Future<void> linkPicturesToComplaint(String complaintId) async {
    print("GOT complaint id!!!!!!!!");
    print(complaintId);

    final CollectionReference complaintsCollection =
        FirebaseFirestore.instance.collection('complaints');
    DocumentReference complaintRef = complaintsCollection.doc(complaintId);
    CollectionReference picturesSubCollection =
        complaintRef.collection('pictures');
    print("reached here!!!!");

    for (int i = 0; i < pictureids.length; i++) {
      String pictureId = pictureids[i];
      print(pictureId);

      DocumentSnapshot pictureSnapshot =
          await FirebaseFirestore.instance.collection('pictures').doc(pictureId).get();
      if (pictureSnapshot.exists) {
        Map<String, dynamic> pictureData =
            pictureSnapshot.data() as Map<String, dynamic>;

        await picturesSubCollection.add(pictureData);
        print('Picture added to subcollection');
      } else {
        print('Picture does not exist');
      }
    }

    for (int i = 0; i < picDocRef.length; i++) {
      DocumentReference picDocReference = picDocRef[i];
      print(picDocReference);
      await picDocReference.delete();
      print("Deleted document reference");
    }

    print("Reached the last part of this function");
  }
}
