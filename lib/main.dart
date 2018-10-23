import 'dart:async';
import 'package:flutter/material.dart';
import 'package:receipt_recogniser_1/cameratab.dart';
import 'package:receipt_recogniser_1/hometab.dart';
import 'package:camera/camera.dart';  
import 'package:receipt_recogniser_1/repo/event/eventstore.dart';
import 'package:receipt_recogniser_1/repo/event/mockeventstore.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

List<CameraDescription> cameras;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

Future<Null> main() async {
  setupDependencies();
  cameras = await availableCameras();
  runApp(new TabbedApp());
}

void setupDependencies() {
  final Injector injector = Injector.getInjector();
  injector.map<EventStore>((i) => new MockEventStore());  
}

class TabbedApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: 3,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.dashboard)),
                Tab(icon: Icon(Icons.camera))
              ]
            ),
            title: Text("Receipt Recognizer")
          ),
          body: TabBarView(
            children: [
              HomeTab(),
              Icon(Icons.dashboard),
              CameraTab(cameras,_scaffoldKey)
            ]
          )
        )
      )
    );
  }
}

