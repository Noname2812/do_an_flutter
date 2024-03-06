import 'package:do_an/ui/widgets/ButtonNavBar.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.widget, required this.index});
  final Widget widget;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.grey[100]),
          child: ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(48), // Image radius
              child: Image.asset('assets/icons/winxd.png', fit: BoxFit.cover),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[100]),
              child: IconButton(
                  icon: const Icon(Icons.notifications), onPressed: () {})),
          Container(
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey[50]),
            child: IconButton(
                icon: const Icon(Icons.account_circle), onPressed: () {}),
          ),
        ],
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
