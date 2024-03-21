import 'package:carousel_slider/carousel_slider.dart';
import 'package:do_an/functionHelpers.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel(
      {super.key,
      required this.list,
      required this.isAutoPlay,
      this.bgColor,
      required this.type,
      required this.height});
  final List<dynamic> list;
  final bool isAutoPlay;
  final Color? bgColor;
  final int type;
  final double height;
  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: widget.bgColor ?? Colors.white,
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: widget.height,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: widget.isAutoPlay,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
              onPageChanged: (position, reason) {
                setState(() {
                  currentIndex = position;
                });
              },
            ),
            items: widget.list.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return widget.type == 1
                      ? Container(child: Image.asset(i))
                      : Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: base64ToImageObject(i),
                                  fit: BoxFit.cover)),
                        );
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: indicators(widget.list.length, currentIndex)),
        ],
      ),
    );
  }
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}
