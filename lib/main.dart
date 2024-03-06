import 'package:do_an/ui/screen/cart/CartPage.dart';
import 'package:do_an/ui/screen/home/HomePage.dart';
import 'package:do_an/ui/widgets/layout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fashion Online',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => const MainLayout(
              widget: HomePage(),
              index: 0,
            ),
        "/cart": (context) => const MainLayout(
              widget: CartPage(),
              index: 1,
            ),
      },
    );
  }
}
