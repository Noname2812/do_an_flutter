// ignore_for_file: must_be_immutable

import 'package:do_an/constants.dart';
import 'package:flutter/material.dart';

class CustomButtonsNavigationBar extends StatelessWidget {
  CustomButtonsNavigationBar({super.key, required this.current});
  final int current;
  List<String> routes = ['/', '/cart'];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: current,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(color: Colors.blue),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        unselectedIconTheme: const IconThemeData(color: Colors.black),
        onTap: (index) => {Navigator.pushNamed(context, routes[index])},
        items: itemsBottomNavigationBav.map((item) {
          return BottomNavigationBarItem(
              label: item.title,
              icon: item.icon,
              backgroundColor: Colors.grey[100]);
        }).toList());
  }
}
