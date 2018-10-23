import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum Category {
  Szambo, Hydrofor, Rekuperator, Other
}

final Map<Category, Icon> categoryIcon = {
  Category.Szambo: Icon(CupertinoIcons.add_circled),
  Category.Hydrofor: Icon(CupertinoIcons.clear_circled_solid),
  Category.Rekuperator: Icon(CupertinoIcons.delete_solid),
  Category.Other: Icon(CupertinoIcons.loop_thick)
};

class Event {
  String title;
  Category category;
  DateTime occurenceDate;
  int reoccurenceDaysCount;
  Event({this.title, this.category, this.occurenceDate, this.reoccurenceDaysCount});
}