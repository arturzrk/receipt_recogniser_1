import 'package:flutter/material.dart';
import 'package:receipt_recogniser_1/model/event.dart';
import 'package:receipt_recogniser_1/repo/event/eventstore.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:receipt_recogniser_1/forms/eventform.dart';


class HomeTab extends StatefulWidget {
  @override
  HomeTabState createState() {
    return new HomeTabState();
  }
}

class HomeTabState extends State<HomeTab> {

  final List<Event> events = <Event>[];
  final Injector injector = Injector.getInjector();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  EventStore service;

  @override
  void initState() {
    super.initState();
    service = injector.get<EventStore>();
    events.addAll(service.getEvents());
    setState(() {
          
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:  buildEventList(),
     floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute( builder: (context) => EventForm())
          );
        },
        tooltip: 'Add New Event',
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget buildEventList() {
    return ListView.builder(
      itemBuilder: (context, i ) {
        if(i.isOdd) return Divider();
        final index = i ~/ 2;
        return buildEventRow(events[index]);
      },
      itemCount: events.length * 2,
    );
  }

  Widget buildEventRow(Event event) {
    return ListTile(
      leading: categoryIcon[event.category],
      title: Text(
        event.title,
        style: _biggerFont,
      ),
      subtitle: buildEventSubtitle(event), 
    );
  }

  Widget buildEventSubtitle(Event event) {
    return Text('${event.occurenceDate.difference(DateTime.now()).inDays} days till next occurence.'
    );
  }
}