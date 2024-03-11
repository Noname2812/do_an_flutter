import 'package:flutter/material.dart';

class ItemButtonNavBar {
  Color? bgColor;
  String title;
  Widget icon;
  int? type;
  ItemButtonNavBar(
      {required this.title, required this.icon, this.bgColor, this.type});
}
