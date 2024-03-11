import 'package:do_an/modals/User.dart';
import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/screen/auth/login.dart';
import 'package:do_an/ui/screen/profile/Profile.dart';
import 'package:do_an/ui/widgets/ButtonNavBar.dart';
import 'package:do_an/ui/widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class LayoutAuth extends StatelessWidget {
  const LayoutAuth({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GetState>(
        converter: (Store<AppState> store) => GetState.fromStore(store),
        builder: (BuildContext context, GetState vm) {
          return vm.isLoading
              ? const Loading(isFullScreen: true)
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.blue[300],
                    title: Text(
                      vm.isLoggedIn ? "Profile" : title,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  body: SafeArea(child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraints.maxHeight),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: vm.isLoggedIn
                                ? Profile(user: vm.user)
                                : const LoginPage(),
                          ),
                        ),
                      );
                    },
                  )),
                  bottomNavigationBar: CustomButtonsNavigationBar(current: 3),
                );
        });
  }
}
