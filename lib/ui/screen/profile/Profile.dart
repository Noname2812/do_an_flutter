import 'package:do_an/functionHelpers.dart';
import 'package:do_an/modals/User.dart';
import 'package:do_an/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class Profile extends StatelessWidget {
  final User user;

  const Profile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GetState>(
      converter: (Store<AppState> store) => GetState.fromStore(store),
      builder: (BuildContext context, GetState vm) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          image: base64ToImageObject(user.image!),
                          fit: BoxFit.fill)),
                ),
              ),
              Center(
                child: Text(
                  user.name!,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            content: const Text("Are you sure logout ?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("No")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    vm.logout(true);
                                  },
                                  child: const Text("Yes")),
                            ],
                          )),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
