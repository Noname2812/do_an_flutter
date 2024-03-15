import 'package:flutter/material.dart';

Widget EmptyWidget(String title, String nameImage) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        "assets/images/$nameImage",
        fit: BoxFit.fill,
      ),
      Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      )
    ],
  );
}
