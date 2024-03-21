import 'package:do_an/ui/screen/product/ListProduct.dart';
import 'package:do_an/ui/widgets/ButtonNavBar.dart';
import 'package:do_an/ui/widgets/SlidePageRoute.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.widget, required this.index});
  final Widget widget;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        automaticallyImplyLeading: false,
        title: const SearchBarApp(),
      ),
      bottomNavigationBar: CustomButtonsNavigationBar(current: index),
      body: SafeArea(child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: widget,
              ),
            ),
          );
        },
      )),
    );
  }
}

class SearchBarApp extends StatelessWidget {
  const SearchBarApp({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        onFieldSubmitted: (value) {
          Navigator.push(
              context,
              SlidePageRoute(
                  page: ListProduct(
                param: "/search/$value",
              )));
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide.none),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          prefixIcon: const Icon(Icons.search),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: "Search",
        ),
      ),
    );
  }
}
