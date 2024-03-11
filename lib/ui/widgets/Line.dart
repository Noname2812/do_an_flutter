import 'package:flutter/material.dart';

Widget createLine(Color color, double height, double width) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    color: color,
    height: height,
    width: width,
  );
}
