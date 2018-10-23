import 'package:receipt_recogniser_1/model/event.dart';

abstract class EventStore {
  List<Event> getEvents();
  String createEvent(Event event);
  Event updateEvent(String eventID, Event updatedEvent);
  void deleteEvent(String eventID);
}