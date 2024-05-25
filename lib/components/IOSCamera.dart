import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> cameras;

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

  Future takePicture() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.image_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (!_cameraController.value.isInitialized) {
                            return;
                          }
                          if (!_cameraController.value.isTakingPicture) {
                            return;
                          }

                          try {
                            await _cameraController.setFlashMode(FlashMode.torch);
                            XFile picture = await _cameraController.takePicture();
                            await _cameraController.setFlashMode(FlashMode.off);
                          } on CameraException catch (e) {
                            debugPrint('Error Done while taking picture: $e');
                            return;
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
        ),
      ),
    );
  }
}
