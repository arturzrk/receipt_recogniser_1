import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras;

class CameraTab extends StatefulWidget {

  CameraTab(List<CameraDescription> _cameras) 
  {
    cameras = _cameras;
  }

  @override
  CameraTabState createState() {
    return new CameraTabState();
  }
}

class CameraTabState extends State<CameraTab> {

  CameraController controller;

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
    if(controller == null || !controller.value.isInitialized)
      return Icon(Icons.camera);
    return new AspectRatio(
      aspectRatio:
      controller.value.aspectRatio,
      child: CameraPreview(controller)
    );
  }
}