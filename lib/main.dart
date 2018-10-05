import 'package:flutter/material.dart';


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
              Icon(Icons.home),
              Icon(Icons.dashboard),
              Icon(Icons.camera)
            ]
          )
        )
      )
    );
  }
}

