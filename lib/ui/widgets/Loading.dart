import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 150,
      child: Center(
          child: Opacity(
        opacity: 1,
        child: CircularProgressIndicator(),
      )),
    );
  }
}
