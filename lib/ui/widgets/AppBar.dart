import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Image.network(
                  "https://thuvienlogo.com/data/04/mau-logo-shop-thoi-trang-dep-06.jpg",
                  height: 100,
                ),
                onTap: () => Navigator.popAndPushNamed(context, "/"),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    color: Colors.grey,
                    child: Icon(Icons.add_comment_outlined),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
