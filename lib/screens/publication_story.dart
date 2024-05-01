import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PublicationStory extends StatefulWidget {
  const PublicationStory({super.key});

  @override
  State<PublicationStory> createState() => _PublicationStoryState();
}

class _PublicationStoryState extends State<PublicationStory> {
  CameraController? _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    await _cameraController!.initialize();
  }

  Future<void> _startVideoRecording() async {
    await _initializeControllerFuture;
    await _cameraController?.startVideoRecording();
  }

  Future<String?> _stopVideoRecording() async {
    final file = await _cameraController?.stopVideoRecording();
    final filePath = file?.path;
    // Faites quelque chose avec le fichier vidéo, comme le sauvegarder ou le lire
    print('Video recorded at $filePath');
    return filePath;
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Example'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_cameraController != null) {
              return CameraPreview(_cameraController!);
            } else {
              return const Center(child: Text('Failed to initialize camera'));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _startVideoRecording();
          await Future.delayed(const Duration(seconds: 10)); // Enregistre pendant 5 secondes
          final filePath = await _stopVideoRecording();
          Navigator.pop(context, filePath);
        },
        child: const Icon(Icons.videocam),
      ),
    );
  }
}
