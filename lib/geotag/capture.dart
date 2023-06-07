/*import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'geotag.dart';
import 'display.dart';

class CaptureImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Capture & Geotag',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CameraController _cameraController;
  Future<void>? _cameraInitialization;
  int _captureCount = 0;
  List<String> _capturedImagePaths = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _cameraInitialization = _cameraController.initialize();

    setState(() {
      // No need to initialize _cameraInitialization with Future.value()
    });
  }

  Future<void> _captureImage() async {
    if (_cameraController.value.isTakingPicture) {
      return; // Return early if a capture is already in progress
    }

    try {
      await _cameraInitialization!;

      final image = await _cameraController.takePicture();

      setState(() {
        _captureCount++;
        _capturedImagePaths.add(image.path); // Store the image path
      });

      // Save the captured image to storage or perform further processing
      // Here, you can upload the image to Firebase Cloud Storage, for example
      // by using the Firebase storage package.
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<void> _navigateToGeotagPage() async {
    List<String>? updatedImagePaths = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GeotagPage(
          capturedImagePaths: _capturedImagePaths,
        ),
      ),
    );

    if (updatedImagePaths != null) {
      setState(() {
        _capturedImagePaths = updatedImagePaths;
      });
    }
  }

  void _discardImage() {
    if (_captureCount > 0) {
      final lastImagePath = _capturedImagePaths.last;
      final file = File(lastImagePath);
      file.delete();

      setState(() {
        _capturedImagePaths.removeLast();
        _captureCount--;
      });
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capture Images'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Capture 3 Images',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Captured: $_captureCount',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<void>(
              future: _cameraInitialization,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return _captureCount > 0
                      ? Image.file(File(_capturedImagePaths.last))
                      : CameraPreview(_cameraController);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _cameraInitialization != null && _captureCount < 3
                    ? _captureImage
                    : null,
                child: Text('Capture'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _captureCount > 0 ? _navigateToGeotagPage : null,
                child: Text('Continue'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _captureCount > 0 ? _discardImage : null,
                child: Text('Discard'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/