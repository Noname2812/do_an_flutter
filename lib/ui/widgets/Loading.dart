import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, required this.isFullScreen});
  final bool isFullScreen;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isFullScreen ? MediaQuery.of(context).size.height : 150,
      child: const Center(
          child: Opacity(
        opacity: 1,
        child: CircularProgressIndicator(),
      )),
    );
  }
}
