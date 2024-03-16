import 'package:do_an/redux/reducer.dart';
import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/screen/auth/LayoutAuth.dart';
import 'package:do_an/ui/screen/cart/CartPage.dart';
import 'package:do_an/ui/screen/home/HomePage.dart';
import 'package:do_an/ui/screen/notification/NotificationPage.dart';
import 'package:do_an/ui/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// ignore: depend_on_referenced_packages
import 'package:redux/redux.dart';

late final Store<AppState> store;
void main() {
  store = Store<AppState>(reducerAppState, initialState: AppState.init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
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
          "/cart": (context) => const CartScreen(),
          "/notifications": (context) => const NotificationPage(),
          "/user": (context) => LayoutAuth(
                title: "Login",
                wiget: null,
              ),
        },
      ),
    );
  }
}
