import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/screen/auth/login.dart';
import 'package:do_an/ui/screen/profile/Profile.dart';
import 'package:do_an/ui/widgets/ButtonNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class LayoutAuth extends StatelessWidget {
  LayoutAuth({super.key, required this.title, this.wiget});
  final String title;
  Widget? wiget;
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GetState>(
        converter: (Store<AppState> store) => GetState.fromStore(store),
        builder: (BuildContext context, GetState vm) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blue[300],
              title: Text(
                vm.isLoggedIn ? "Profile" : title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            body: SafeArea(child: LayoutBuilder(
              builder: (context, constraints) {
                return wiget ??
                    SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: vm.isLoggedIn
                            ? Profile(user: vm.user)
                            : const LoginPage(),
                      ),
                    );
              },
            )),
            bottomNavigationBar: CustomButtonsNavigationBar(current: 3),
          );
        });
  }
}
