import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


List<CameraDescription> cameras;
GlobalKey<ScaffoldState> _scaffoldKey;

class CameraTab extends StatefulWidget {
  CameraTab(List<CameraDescription> _cameras, GlobalKey<ScaffoldState> _key) 
  {
    cameras = _cameras;
    _scaffoldKey = _key;
  }

  @override
  CameraTabState createState() {
    return new CameraTabState();
  }
}

class CameraTabState extends State<CameraTab> {

  CameraController controller;
  String lastImagePath;

  @override
  void initState() {
    super.initState();
    if(cameras.length==0)
      return;
    controller = new CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Expanded( 
          child: cameraPreviewRow()
        ),
        cameraControlButtons()
      ]
    );
  }
        
  Widget cameraPreviewRow() {
    if(controller == null || !controller.value.isInitialized) {
      return Text(
        'Camera is not available.',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w900
        ),
      ); 
    } else {
      return AspectRatio(
          aspectRatio:
          controller.value.aspectRatio,
          child: CameraPreview(controller)
      );
    }
  }
        
  Widget cameraControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: takePicturePressed,
          )
      ]
    );
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

    void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
  
  void takePicturePressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          lastImagePath = filePath;
        });
        if( lastImagePath != null)
          showInSnackBar('Picture saved to $lastImagePath.');
      }
    });
  }
}