import 'package:do_an/functionHelpers.dart';
import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/screen/profile/DetailOrder.dart';
import 'package:do_an/ui/widgets/ButtonNavBar.dart';
import 'package:do_an/ui/widgets/EmptyWidget.dart';
import 'package:do_an/ui/widgets/SlidePageRoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: const Text(
          "Notification",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: store.state.notifications.isEmpty || !store.state.isLogined
                ? EmptyWidget("No notification", "no_results.png")
                : Column(
                    children: [
                      ...(store.state.notifications).map((e) => InkWell(
                            onTap: () => Navigator.push(
                                context,
                                SlidePageRoute(
                                    page: DetailOrder(
                                  id: e.body!.split(' ')[2],
                                ))),
                            child: Card(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(e.title!),
                                    Text(e.body!),
                                    Text(convertDateTime(e.createdAt!))
                                  ],
                                ),
                              ),
                            ),
                          ))
                    ],
                  )),
      ),
      bottomNavigationBar: CustomButtonsNavigationBar(current: 1),
    );
  }
}
