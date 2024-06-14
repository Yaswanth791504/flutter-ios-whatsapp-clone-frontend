import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:textz/main.dart';
import 'package:textz/screens/IOSImageSender.dart';

class IOSCamera extends StatefulWidget {
  const IOSCamera({super.key});

  @override
  State<IOSCamera> createState() => _IOSCameraState();
}

class _IOSCameraState extends State<IOSCamera> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool _isRearCamera = false;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<dynamic> takePicture() async {
    try {
      await _cameraController.setFlashMode(FlashMode.torch);
      XFile picture = await _cameraController.takePicture();
      Navigator.push(context, MaterialPageRoute(builder: (context) => IOSImageSender(image: picture)));
      await _cameraController.setFlashMode(FlashMode.off);
    } on CameraException catch (e) {
      debugPrint('Error Done while taking picture: $e');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FutureBuilder<void>(
          future: cameraValue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_cameraController);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 30.0),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    onPressed: takePicture,
                    icon: const Icon(
                      Icons.image_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      try {
                        print('clicked');
                        await _cameraController.setFlashMode(FlashMode.always);
                        XFile picture = await _cameraController.takePicture();
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => IOSImageSender(image: picture)));
                        await _cameraController.setFlashMode(FlashMode.off);
                      } catch (e) {
                        print('Error happend ${e.toString()}');
                      }
                    },
                    icon: const Icon(
                      Icons.circle_outlined,
                      size: 100.0,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isRearCamera = !_isRearCamera;
                        _cameraController = CameraController(cameras[_isRearCamera ? 1 : 0], ResolutionPreset.high);
                        cameraValue = _cameraController.initialize();
                      });
                    },
                    icon: Icon(
                      _isRearCamera ? Icons.flip_camera_ios_outlined : Icons.flip_camera_ios,
                      color: Colors.white,
                      shadows: const [
                        Shadow(
                          color: Colors.black,
                        )
                      ],
                      size: 40,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
