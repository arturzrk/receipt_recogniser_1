import 'package:flutter/material.dart';
import 'package:receipt_recogniser_1/hometab.dart';


void main() => runApp(new TabbedApp());


class TabbedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: 3,
        child: Scaffold(
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
              Icon(Icons.camera)
            ]
          )
        )
      )
    );
  }
}

