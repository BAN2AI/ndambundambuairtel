import 'package:flutter/widgets.dart';

class Category {
  int id;
  String name;
  String image;
  IconData icon;
  bool isSelected;
  Category({this.id, this.name, this.isSelected = false, this.icon});
}
