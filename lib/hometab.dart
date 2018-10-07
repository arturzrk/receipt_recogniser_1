import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  @override
  HomeTabState createState() {
    return new HomeTabState();
  }
}

class HomeTabState extends State<HomeTab> {
  int clickCount = 2;

  void incrementCounter() {
    setState(() {
          clickCount++;
        });
  }

  void decrementCounter() {
    setState(() {
          clickCount--;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '$clickCount',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                child: Text(
                  'Increment'
                ),
                onPressed: incrementCounter,
              ),
              RaisedButton(
                child: Text(
                  'Decrement'
                ),
                onPressed: decrementCounter,
              )
            ]
          )
        ]
      )
    );
  }
}