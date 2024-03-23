import 'package:do_an/redux/reducer.dart';
import 'package:do_an/redux/store.dart';
import 'package:do_an/services/NotificationServices.dart';
import 'package:do_an/ui/screen/auth/LayoutAuth.dart';
import 'package:do_an/ui/screen/cart/CartPage.dart';
import 'package:do_an/ui/screen/home/HomePage.dart';
import 'package:do_an/ui/screen/notification/NotificationPage.dart';
import 'package:do_an/ui/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:redux/redux.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

late final Store<AppState> store;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  store = Store<AppState>(reducerAppState, initialState: AppState.init());
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    store.state.services.requestNotificationPermission();
    store.state.services.forgroundMessage();
    store.state.services.firebaseInit(context);
    store.state.services.setupInteractMessage(context);
    store.state.services.isTokenRefresh();
    store.state.services.getDeviceToken().then((value) {
      print('device token');
      print(value);
    });
  }

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
